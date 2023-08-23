import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_project/api/net/fetch.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      floatingActionButton: FloatingActionButton (
        onPressed: () {
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
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "좋아하는 영화를 소개!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
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
                          Text(
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
                      const Text(
                        '영화를 추천하고 싶어요!!',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog (
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return MovieListDialog(movieList: movieList);
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
                      )
                    ],
                  ),
                ),
              );
            }
          );
        },

        child: const Icon (
          Icons.add_comment_sharp,
        ),
      ),
    );
  }
}

class MovieListDialog extends StatefulWidget {

  final List<dynamic> movieList;

  const MovieListDialog({Key? key, required this.movieList}) : super(key: key);

  @override
  State<MovieListDialog> createState() => _MovieListDialogState();
}

class _MovieListDialogState extends State<MovieListDialog> {

  List<dynamic> _loadedMovieList = [];

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
          /*
          Expanded (
            child: Form (
              key: _movieKey,
              child: Padding (
                padding: const EdgeInsets.all(8.0),
                child: TextFormField (
                  controller: _movieController,
                  decoration: const InputDecoration(
                    hintText: '영화 이름을 입력해주세요',
                  ),
                ),
              ),
            ),
          ),
          */

          ElevatedButton (
            onPressed: () {
              _loadMovieFetch();
            },

            child: const Text (
                '영화 로딩'
            ),
          ),

          const SizedBox(height: 10), // Add spacing between Form and ListView

          Expanded(
            child: ListView.separated (
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text('${_loadedMovieList[index]['movieNm']}');
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _loadedMovieList.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadMovieFetch() async {
    try {
      var json = await fetch('/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json', {
        'targetDt': '20221017'
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