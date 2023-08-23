import 'package:flutter/material.dart';
import 'package:movie_app_project/utils/text.dart';

class Description extends StatelessWidget {

  final String name, description, bannerUrl, postUrl, vote, launch_on;

  const Description({super.key, required this.name, required this.description, required this.bannerUrl, required this.postUrl, required this.vote, required this.launch_on});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: Container (
        height: 650,
        margin: EdgeInsets.only(left: 4.0, right: 4.0),
        child: Card (
          color: Colors.white,
          elevation: 12.0,
          
          child: ListView (
            children: [
              Card (
                color: Colors.white,
                child: Container (
                  color: Colors.white,
                  margin: const EdgeInsets.all(6),
                  width: 80,
                  height: 120,
                  child: Stack (
                    children: [
                      Positioned (
                        child: Container (
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network (
                            bannerUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned (
                        bottom: 10,
                        child: ModifiedText(
                            text: '✨ 평점 - $vote 점',
                            color: Colors.white,
                            size: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox (
                height: 16,
              ),

              Container (
                padding: const EdgeInsets.all(10),
                child: ModifiedText (
                    text: name ?? 'Not Loaded',
                    color: Colors.black,
                    size: 24
                ),
              ),

              Container (
                padding: const EdgeInsets.only(left: 10),
                child: ModifiedText (
                    text: 'Releasing On - ' + launch_on,
                    color: Colors.black,
                    size: 14,
                ),
              ),

              Row (
                children: [
                  Container (
                    margin: const EdgeInsets.all(5),
                    height: 200,
                    width: 100,
                    child: Image.network (
                        postUrl
                    ),
                  ),
                ],
              ),

              Padding (
                padding: const EdgeInsets.all(8.0),
                child: Flexible (
                  child: ModifiedText (
                    text: description,
                    size: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
