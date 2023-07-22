import 'package:flutter/material.dart';
import 'package:movie_app_project/utils/text.dart';
import 'package:movie_app_project/widgets/description.dart';

class TrendingMovies extends StatelessWidget {

  final List trending;

  const TrendingMovies({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 40),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const ModifiedText(text: '요즘 유행하고 있는 영화', size: 26, color: Colors.black,),
          Padding (
            padding: const EdgeInsets.only(top: 24.0),
            child: SizedBox (
              height: 330,
              child: ListView.builder (
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  return InkWell (
                    onTap: () {
                      Navigator.of(context).push (
                        MaterialPageRoute(builder: (context) => Description (
                            name: trending[index]['title'],
                            description: trending[index]['overview'],
                            bannerUrl: 'https://image.tmdb.org/t/p/w500' + trending[index]['backdrop_path'],
                            postUrl: 'https://image.tmdb.org/t/p/w500' + trending[index]['poster_path'],
                            vote: trending[index]['vote_average'].toString(),
                            launch_on: trending[index]['release_date'],
                        ))
                      );
                    },

                    child: trending[index]['title'] != null ? SizedBox (
                      width: 140,
                      child: Column (

                        children: [
                          Container (
                            height: 200,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage (
                                image: NetworkImage (
                                  'https://image.tmdb.org/t/p/w500' + trending[index]['poster_path']
                                )
                              )
                            ),
                          ),

                          Center (
                            child: Container (
                              width: 120,

                              child: Padding (
                                padding: const EdgeInsets.only(top: 13.0),
                                child: ModifiedText (
                                    text: trending[index]['title'] ?? '알 수 없음',
                                    color: Colors.black45,
                                    size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ) : Container (),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
