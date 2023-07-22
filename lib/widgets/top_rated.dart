import 'package:flutter/material.dart';
import 'package:movie_app_project/utils/text.dart';

class TopRated extends StatelessWidget {

  final List topRated;

  const TopRated({Key? key, required this.topRated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const ModifiedText(text: '정말 모르면 안되는 영화들!', size: 26, color: Colors.black,),
          Padding (
            padding: const EdgeInsets.only(top: 24.0),
            child: SizedBox (
              height: 330,
              child: ListView.builder (
                scrollDirection: Axis.horizontal,
                itemCount: topRated.length,
                itemBuilder: (context, index) {
                  return InkWell (
                    onTap: () {

                    },

                    child: SizedBox (
                      width: 140,
                      child: Column (

                        children: [
                          Container (
                            height: 200,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(40),
                                image: DecorationImage (
                                    image: NetworkImage (
                                        'https://image.tmdb.org/t/p/w500' + topRated[index]['poster_path']
                                    )
                                )
                            ),
                          ),

                          Row (
                            children: [
                              SizedBox (
                                width: 120,

                                child: Padding (
                                  padding: const EdgeInsets.only(top: 13.0),
                                  child: ModifiedText (
                                    text: topRated[index]['title'] ?? '알 수 없음',
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
