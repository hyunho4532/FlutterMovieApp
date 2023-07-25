import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app_project/const/widget/bottom_navi_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  bool _isObSecureText = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  '환영합니다! MVT입니다.',
                  style: TextStyle (
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),

              const Padding (
                padding: EdgeInsets.only(left: 10, right: 10, top: 32),
                child: Text (
                  'MVT는 사용자들이 영화를',
                  style: TextStyle (
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),

              const SizedBox (
                height: 4.0,
              ),

               const Padding (
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text (
                  '편안하게 볼 수 있게 많은걸 도와드리겠습니다!',
                  style: TextStyle (
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(left: 12.0, top: 80.0),
                child: Form (
                  child: TextFormField (
                    controller: _nicknameController,
                    cursorRadius: const Radius.circular(40),
                    style: const TextStyle (
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration (
                      enabledBorder: UnderlineInputBorder (
                        borderSide: BorderSide (color: Colors.black),
                      ),
                      hintText: '닉네임을 입력해주세요.',
                      hintStyle: TextStyle (
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(left: 12.0, top: 40.0),
                child: Form (
                  child: TextFormField (
                    controller: _emailController,
                    cursorRadius: const Radius.circular(40),
                    style: const TextStyle (
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration (
                      enabledBorder: UnderlineInputBorder (
                        borderSide: BorderSide (color: Colors.black),
                      ),
                      hintText: '이메일을 입력해주세요.',
                      hintStyle: TextStyle (
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(left: 12.0, top: 40.0),
                child: Form (
                  child: TextFormField (
                    controller: _passwordController,
                    style: const TextStyle (
                      color: Colors.black
                    ),
                    decoration: InputDecoration (
                      enabledBorder: const UnderlineInputBorder (
                        borderSide: BorderSide (color: Colors.black),
                      ),
                      hintStyle: const TextStyle (
                        color: Colors.grey,
                      ),
                      suffixIcon: _isObSecureText == false ? IconButton (
                          onPressed: () {
                            setState(() {
                              _isObSecureText = true;
                            });
                          }, icon: const Icon(Icons.remove_red_eye),
                      ) : IconButton(onPressed: () {
                        setState(() {
                          _isObSecureText = false;
                        });
                      }, icon: const Icon(Icons.remove_red_eye_outlined)),
                      hintText: '비밀번호를 입력해주세요.',
                    ),
                    obscureText: _isObSecureText == false ? false : true,
                  ),
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(left: 12.0, top: 40.0),
                child: SizedBox (
                  height: 40,
                  width: MediaQuery.of(context).size.width,

                  child: ElevatedButton (
                      onPressed: () {
                        firebaseRegister();
                      },
                      child: const Text (
                        '회원가입 완료'
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  void firebaseRegister() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
        ).then((value) {
      if (value.user!.email != null) {
        Navigator.of(context).push (
          MaterialPageRoute(builder: (_) => const BottomNaviBar()),
        );
      } else {

      }
      return value;
    });

    _auth.currentUser?.sendEmailVerification();
  }
}
