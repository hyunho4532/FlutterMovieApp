import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app_project/controller/image/image_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? data = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController profileNicknameController =
      TextEditingController();

  final ImageController controller = ImageController();

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

  Future<String> getProfileNickNameData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Call Profile NickName';
  }

  Future<String> getProfileImageData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Call Profile Image';
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref(_auth.currentUser!.uid.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: TextFormField(
                    controller: profileNicknameController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    decoration: const InputDecoration(
                        hintText: '원하는 닉네임을 입력해주세요.',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    ref.set({"nickname": profileNicknameController.text});
                  },
                  child: const Text('입력 완료'),
                ),
              ),
            ],
          ),

          FutureBuilder (
            future: getProfileNickNameData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding (
                  padding: EdgeInsets.only(left: 12.0, top: 36.0),
                  child: Row (
                    children: [
                      Text (
                        '데이터를 로딩 중입니다.',
                        style: TextStyle (
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox (
                        width: 16.0,
                      ),

                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text ('Error ${snapshot.error}');
              } else {
                if (data == 'null') {
                  return const Padding (
                    padding: EdgeInsets.only(left: 12.0, top: 36.0),
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text (
                          '닉네임을 입력해주세요!!',
                          style: TextStyle (
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox (
                          height: 16.0,
                        ),

                        Text (
                          '프로필을 조회하기 전 간단한 닉네임 작성해주세요~!',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding (
                    padding: const EdgeInsets.only(left: 12.0, top: 36.0),
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text (
                          '안녕하세요 $data 님',
                          style: const TextStyle (
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox (
                          height: 16.0,
                        ),

                        Text (
                          '$data 님을 위한 프로필 사진을 만들어보세요~!',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        Padding (
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Column (
                            children: [
                              Center(
                                child: GestureDetector (
                                    onTap: () {
                                      controller.getImage(ImageSource.gallery);
                                    },
                                    child: Obx(
                                          () => SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: controller.selectedImagePath.value != ''
                                            ? CircleAvatar(
                                            backgroundImage: FileImage(
                                                File(controller.selectedImagePath.value)))
                                            : Image.asset('asset/profile.png'),
                                      ),
                                    )
                                ),
                              ),

                              Center (
                                child: Row (
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    SizedBox (
                                      width: MediaQuery.of(context).size.width / 3,

                                      child: ElevatedButton (
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black12,
                                        ),
                                        onPressed: () {
                                          _auth.signOut();

                                          Get.toNamed('/register');
                                        },

                                        child: const Text (
                                          '로그아웃',
                                          style: TextStyle (
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
          ),
        ],
      ),
    );
  }
}
