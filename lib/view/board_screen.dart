import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_project/api/net/fetch.dart';
import 'package:movie_app_project/model/movieName.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class BoardScreen extends StatefulWidget {

  const BoardScreen({Key? key, required ValueNotifier<ThemeMode> themeNotifier}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<dynamic> movieList = [];
  final FirebaseAuth _nicknameAuth = FirebaseAuth.instance;
  final FirebaseDatabase _nickNameRef = FirebaseDatabase.instance;
  final _movieKey = GlobalKey<FormState>();
  final TextEditingController _movieController = TextEditingController();

  String? loadedMovieList;

  String? selectedMovieName;

  late String _nickName = "";

  @override
  void initState() {
    super.initState();
    _loadNickName();
  }

  Future<void> _loadNickName() async {
    final nicknameSnapshot = await _nickNameRef
        .reference()
        .child(_nicknameAuth.currentUser!.uid.toString())
        .child("nickname")
        .once();

    setState(() {
      _nickName = nicknameSnapshot.snapshot.value.toString(); // Extract the value from DataSnapshot
    });
  }

  String? movieListName;

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          showMovieInsertDialog(context, movieListName);
        },

        child: const Icon (
          Icons.add_comment_sharp,
        ),
      ),
    );
  }

  void showMovieInsertDialog(context, loadedMovieList) {

    void updateSelectedMovieName(String movieName) {
      selectedMovieName = movieName;
      print(selectedMovieName);
    }

    showDialog (
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: double.infinity,
              height: 560,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "좋아하는 영화를 입력하여!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text (
                    "사람들에게 알려주세요~!",
                    style: TextStyle (
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '이름: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),

                      Text (
                        _nickName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 28.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog (
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return MovieListDialog (
                            movieList: movieList,
                            onMovieSelected: updateSelectedMovieName,
                          );
                        },
                      );
                    },
                    child: const Text(
                      '영화 입력하러 가기',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Text (
                    selectedMovieName.toString() ?? "",
                    style: const TextStyle (
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

class MovieListDialog extends StatefulWidget {

  final List<dynamic> movieList;

  final Function(String) onMovieSelected;

  const MovieListDialog({Key? key, required this.movieList, required this.onMovieSelected}) : super(key: key);

  @override
  State<MovieListDialog> createState() => _MovieListDialogState();
}

class _MovieListDialogState extends State<MovieListDialog> {

  List<dynamic> _loadedMovieList = [];

  final TextEditingController _dateEditingController = TextEditingController();
  final GlobalKey _dataGlobalKey = GlobalKey<FormState>();

  final _BoardScreenState _boardScreenState = _BoardScreenState();

  var movieNameManager = MovieNameManager();

  @override
  void initState() {
    super.initState();
    _loadedMovieList = widget.movieList;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Padding (
            padding: const EdgeInsets.all(12.0),
            child: Form (
              child: TextFormField (
                controller: _dateEditingController,

                onTap: () {

                },

                decoration: const InputDecoration (
                    hintText: '날짜를 입력해주세요 ex) 20230826',
                    hintStyle: TextStyle (
                      fontSize: 16.0,
                      color: Colors.grey,
                    )
                ),
              ),
            ),
          ),

          const SizedBox (
            height: 12.0,
          ),

          SizedBox (
            width: MediaQuery.of(context).size.width - 120,

            child: ElevatedButton (
              onPressed: () {
                _loadMovieFetch();
              },

              child: const Column (
                children: [
                  Text (
                      '영화 조회'
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10), // Add spacing between Form and ListView

          Expanded (
            child: Padding (
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated (
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector (
                    onTap: () {
                      Navigator.of(context).pop(_loadedMovieList[index]['movieNm']);
                      widget.onMovieSelected(_loadedMovieList[index]['movieNm']);
                    },
                    child: Text('${_loadedMovieList[index]['movieNm']}')
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _loadedMovieList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadMovieFetch() async {
    try {
      var json = await fetch('/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json', {
        'targetDt': _dateEditingController.text
      });

      print("Fetched JSON: $json"); // Add this line

      setState(() {
        _loadedMovieList = json['boxOfficeResult']['dailyBoxOfficeList'];
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}