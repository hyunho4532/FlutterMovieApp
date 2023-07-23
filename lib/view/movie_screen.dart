import 'package:flutter/material.dart';
import 'package:movie_app_project/view/actor_movie.dart';
import 'package:movie_app_project/widgets/top_rated.dart';
import 'package:movie_app_project/widgets/trending.dart';
import 'package:movie_app_project/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with SingleTickerProviderStateMixin {

  List trendingmovies = [];
  List topRatedMovies = [];
  List tv = [];
  List actors = [];

  TextEditingController actorController = TextEditingController();
  final GlobalKey<FormState> _actorKey = GlobalKey();

  String actorName = '';

  final String apiKey = 'ff5fd275ee5111ed49345c916c46c177';
  final readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZjVmZDI3NWVlNTExMWVkNDkzNDVjOTE2YzQ2YzE3NyIsInN1YiI6IjY0MTlhYjgwMGQ1ZDg1MDBiYTEwZDU0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IZEX0iX9VfINBnA7RmKA-ImdpxtWyaU1nKl_rvg22KU';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    final tmDBWithCustomLogs = TMDB(
        ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger (
          showLogs: true,
          showErrorLogs: true,
        )
    );

    Map trendingResult = await tmDBWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmDBWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmDBWithCustomLogs.v3.tv.getPopular();
    Map actorResult = await tmDBWithCustomLogs.v3.search.queryPeople(actorName);

    setState(() {
      trendingmovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tv = tvResult['results'];
      actors = actorResult['results'];
    });

    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.white,
        body: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row (
              children: [
                Padding (
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: SizedBox (
                    width: 250,
                    height: 40,
                    child: Form (
                      child: TextField (
                        controller: actorController,
                        key: _actorKey,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.black,
                        style: const TextStyle (
                          color: Colors.black
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration (
                          hintText: '원하는 배우 이름 입력',
                          contentPadding: EdgeInsets.only(left: 6.0),
                          hintStyle: TextStyle (
                            color: Colors.grey,
                            decorationColor: Colors.black,
                            fontSize: 18.0,
                          ),
                          prefixIcon: Icon(Icons.account_circle),
                          fillColor: Colors.black,
                        ),
                        onChanged: (value) {
                          setState(() {
                            actorName = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                Padding (
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox (
                    height: 30,
                    child: ElevatedButton (
                      onPressed: () {
                        loadMovies();
                      },
                      child: const Text('입력 완료')
                    ),
                  ),
                )
              ],
            ),

            Expanded (
              child: ListView (
                children: [
                  TV(tv: tv),
                  TopRated(topRated: topRatedMovies),
                  TrendingMovies(trending: trendingmovies),

                  const Row (
                    children: [
                      Padding (
                        padding: EdgeInsets.only(left: 10, right: 10, top: 28),
                        child: Text (
                          '검색을 하시면 \n아래 유명 배우들이 조회돼요!',
                          style: TextStyle (
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ActorMovies(actor: actors),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
