import 'package:flutter/material.dart';

class ActorMovies extends StatelessWidget {

  final List actor;

  const ActorMovies({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.all(10),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding (
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
            child: SizedBox (
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
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
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage (
                                  image: NetworkImage (
                                      'https://image.tmdb.org/t/p/w500' + actor[index]['profile_path']
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: actor.length
              ),
            ),
          )
        ],
      ),
    );
  }
}
