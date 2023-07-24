import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void dataBaseSet() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/1234");

    await ref.set ({
      "name": "John",
      "age": 18,
    });
  }

  @override
  void initState() {
    super.initState();

    dataBaseSet();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold (
      backgroundColor: Colors.white,
      body: Text (
          'Profile'
      ),
    );
  }
}
