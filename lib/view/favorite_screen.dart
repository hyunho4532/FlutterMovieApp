import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> actorUrls = [];

  String newData = '';

  @override
  void initState() {
    super.initState();
    fetchFavoriteActors();
  }

  void fetchFavoriteActors() {
    Query dbRef = FirebaseDatabase.instance.ref("favorite/actors").child(_auth.currentUser!.uid.toString());

    dbRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          // Update the actorUrls with the values from the Realtime Database
          actorUrls = data.values.cast<String>().toList();
          newData = data.values.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12.0, top: 24.0),
            child: Text(
              '안녕하세요, 님',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 12.0, top: 180.0),
            child: Text(
              'User 님의 가장 좋아하는 배우',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Padding (
              padding: const EdgeInsets.only(left: 8.0, top: 24.0),
              child: SizedBox (
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: actorUrls.length,
                  itemBuilder: (BuildContext context, int index) {
                    String actorUrl = actorUrls[index];
                    return Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(250),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500$actorUrl',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}