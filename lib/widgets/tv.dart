import 'package:flutter/material.dart';
import 'package:movie_app_project/utils/text.dart';

class TV extends StatelessWidget {

  final List tv;

  TV({Key? key, required this.tv, required this.themeNotifier}) : super(key: key);

  ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ModifiedText (
            text: 'TV로 많이 보고 있는 영화',
            size: 26,
            color: themeNotifier.value == ThemeMode.light ? Colors.black : Colors.white,
          ),
          Padding (
            padding: const EdgeInsets.only(top: 24.0),
            child: SizedBox (
              height: 280,
              child: ListView.builder (
                scrollDirection: Axis.horizontal,
                itemCount: tv.length,
                itemBuilder: (context, index) {
                  return InkWell (
                    onTap: () {

                    },

                    child: Container (
                      padding: EdgeInsets.all(5),
                      width: 250,
                      child: Column (

                        children: [
                          Container (
                            width: 250,
                            height: 140,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(20),
                                image: DecorationImage (
                                    image: NetworkImage (
                                        'https://image.tmdb.org/t/p/w500' + tv?[index]['backdrop_path']
                                    )
                                ),
                            ),
                          ),

                          Center (
                            child: Container (
                              width: 120,

                              child: Padding (
                                padding: const EdgeInsets.only(top: 13.0),
                                child: ModifiedText (
                                  text: tv[index]['original_name'] ?? '알 수 없음',
                                  color: themeNotifier.value == ThemeMode.light ? Colors.black45 : Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
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
