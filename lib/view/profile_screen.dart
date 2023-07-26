import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String data = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController profileNicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadDataFromSharedPreferences();

    getDataFromFirebase();
  }

  void loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data = prefs.getString('data') ?? '';
    });
  }

  void getDataFromFirebase() {
    DatabaseReference starCountRef = FirebaseDatabase.instance
        .reference()
        .child(_auth.currentUser!.uid.toString())
        .child('nickname');

    starCountRef.onValue.listen((event) {
      String newData = event.snapshot.value.toString() ?? '';
      setState(() {
        data = newData;
        saveDataToSharedPreferences(newData);
      });
    });
  }

  void saveDataToSharedPreferences(String newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('data', newData);
  }

  @override
  Widget build(BuildContext context) {

    DatabaseReference ref = FirebaseDatabase.instance.ref(_auth.currentUser!.uid.toString());

    return Scaffold (
      backgroundColor: Colors.white,
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row (
            children: [
              Expanded (
                child: Padding (
                  padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                  child: TextFormField (
                    controller: profileNicknameController,
                    style: const TextStyle (
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    decoration: const InputDecoration (
                      hintText: '원하는 닉네임을 입력해주세요.',
                      hintStyle: TextStyle (
                        color: Colors.grey,
                      )
                    ),
                  ),
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(top: 40.0, right: 8.0),
                child: ElevatedButton (
                  onPressed: () {
                    ref.set ({
                      "nickname": profileNicknameController.text
                    });
                  },
                  child: const Text('입력 완료'),
                ),
              ),
            ],
          ),


          Padding (
            padding: const EdgeInsets.only(left: 12.0, top: 36.0),
            child: Text (
              '안녕하세요, $data 님',
              style: const TextStyle (
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),


          const Padding (
            padding: EdgeInsets.only(left: 12.0, top: 36.0),
            child: Text (
              '프로필을 조회해드립니다~!',
              style: TextStyle (
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const Padding (
            padding: EdgeInsets.only(top: 32.0),
            child: Center (
              child: CircleAvatar (
                radius: 60,
                backgroundImage: AssetImage (
                    'asset/profile.png'
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
