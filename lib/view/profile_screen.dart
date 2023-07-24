import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Query dbRef = FirebaseDatabase.instance.ref().child('favorite/actors');

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Padding (
            padding: EdgeInsets.only(left: 12.0, top: 24.0),
            child: Text (
              '안녕하세요, User 님',
              style: TextStyle (
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const Padding (
            padding: EdgeInsets.only(left: 12.0, top: 12.0),
            child: Text (
              '프로필을 조회해드립니다~!',
              style: TextStyle (
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const Center (
            child: CircleAvatar (
              radius: 60,
              backgroundImage: AssetImage (
                  'asset/profile.png'
              ),
            ),
          ),

          Expanded (
            child: SizedBox (
              height: double.infinity,
              child: FirebaseAnimatedList (
                query: dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  String actors = snapshot.value.toString();

                  return Column (
                    children: [
                      Container (
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration (
                          image: DecorationImage (
                            image: NetworkImage (
                                'https://image.tmdb.org/t/p/w500$actors'
                            ),
                          )
                        ),
                      )
                    ],
                  );
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}
