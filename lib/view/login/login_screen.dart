import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_project/const/widget/bottom_navi_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailCheckController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,

      body: Padding (
        padding: const EdgeInsets.all(24.0),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Padding (
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Text (
                '이미 회원가입을 하셨군요',
                style: TextStyle (
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            Padding (
              padding: const EdgeInsets.only(left: 10, right: 10, top: 70),
                child: TextFormField (
                  style: const TextStyle (
                    color: Colors.black,
                  ),
                  controller: _emailCheckController,
                  decoration: const InputDecoration (
                    hintText: '이메일을 입력해주세요',
                    hintStyle: TextStyle (
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),

                    enabledBorder: UnderlineInputBorder (
                      borderSide: BorderSide (color: Colors.black),
                    ),
                  ),
                ),
            ),

            Padding (
              padding: const EdgeInsets.only(left: 10, right: 10, top: 45),
              child: TextFormField (
                style: const TextStyle (
                  color: Colors.black,
                ),
                controller: _passwordCheckController,
                decoration: const InputDecoration (
                  hintText: '비밀번호를 입력해주세요',
                  hintStyle: TextStyle (
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),

                  enabledBorder: UnderlineInputBorder (
                    borderSide: BorderSide (color: Colors.black),
                  ),
                ),
              ),
            ),

            Padding (
              padding: const EdgeInsets.only(left: 10, right: 10, top: 45),
              child: SizedBox (
                height: 40,
                width: MediaQuery.of(context).size.width,

                child: ElevatedButton (
                  onPressed: () {
                    firebaseLogin(_emailCheckController.text, _passwordCheckController.text);
                  },

                  child: const Text ("로그인 완료"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void firebaseLogin(String email, String password) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.signInWithEmailAndPassword (
        email: email, password: password
    ).then((value) {
      if (value.user!.email != null) {
        Navigator.of(context).push (
          MaterialPageRoute(builder: (_) => const BottomNaviBar()),
        );
      } else {

      }
      return value;
    });
  }
}
