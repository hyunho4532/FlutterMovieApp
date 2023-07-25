import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Widget movieDialog(List<dynamic> actor, int index) {
  return AlertDialog (
    title: const Row(
      children: [
        Text (
          '내가 좋아하는 배우명',
          style: TextStyle (
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox (
          width: 32.0,
        ),

        Icon (
          Icons.favorite,
          color: Colors.red,
          size: 40,
        ),
      ],
    ),
    backgroundColor: Colors.white,
    content: Column (
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding (
          padding: const EdgeInsets.only(top: 16.0),
          child: Text (
            actor[index]['name'],
            style: const TextStyle (
                color: Colors.black
            ),
          ),
        ),

        Padding (
          padding: const EdgeInsets.only(top: 40.0),
          child: Center (
            child: ElevatedButton (
              onPressed: () async {

                FirebaseAuth _auth = FirebaseAuth.instance;

                DatabaseReference ref = FirebaseDatabase.instance.ref("favorite/actors").child(_auth.currentUser!.uid.toString());

                await ref.set ({
                  "name": actor[index]['name'].toString(),
                  "path": actor[index]['profile_path'].toString(),
                });
              },

              child: const Text('등록하기'),
            ),
          ),

        )
      ],
    ),
  );
}