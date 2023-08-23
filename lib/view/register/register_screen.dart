import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app_project/api/google/login/GoogleSignInApi.dart';
import 'package:movie_app_project/view/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailController = TextEditingController();
  final _formEmailKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final _formPasswordKey = GlobalKey<FormState>();

  final TextEditingController _nicknameController = TextEditingController();
  final _formNickNameKey = GlobalKey<FormState>();

  bool _isObSecureText = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _nicknameDatabase = FirebaseDatabase.instance;

  late String _nickname = '';

  @override
  Widget build(BuildContext context) {
      return Scaffold (
        backgroundColor: Colors.white,
        body: Padding (
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView (
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
                  
                  Center (
                      child: Lottie.asset (
                          'asset/lottie/register.json'
                      )
                  ),

                  Padding (
                    padding: const EdgeInsets.only(left: 12.0, top: 20.0),
                    child: Form (
                      key: _formNickNameKey,
                      child: TextFormField (
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "닉네임을 입력해주세요";
                          }

                          setState(() {
                            _nickname = value;
                          });

                          return null;
                        },
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
                      key: _formEmailKey,
                      child: TextFormField (
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "이메일을 입력해주세요.";
                          }

                          if (!value.contains("@")) {
                            return "이메일에는 @가 필수입니다.";
                          }

                          return null;
                        },
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
                      key: _formPasswordKey,
                      child: TextFormField (
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "패스워드를 입력해주세요.";
                          }

                          return null;
                        },
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
                          ),
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
                            loginWithGoogle(context);
                          },
                          child: const Text (
                              'Google 계정으로 간편 로그인',
                          )
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
                            Get.toNamed('/login');
                          },
                          child: const Text (
                              '이미 회원가입을 하셨을까요?'
                          )
                      ),
                    ),
                  ),
                ],
              ),
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
        Navigator.of(context).push (
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );

      return value;
    });

    _nicknameDatabase.ref(_auth.currentUser!.uid.toString()).child("nickname").set(_nicknameController.text);

    _auth.currentUser?.sendEmailVerification();
  }

  Future<UserCredential> loginWithGoogle(BuildContext context) async {
    GoogleSignInAccount? user = await GoogleSignInApi.login();

    GoogleSignInAuthentication? googleAuth = await user!.authentication;

    var credential = GoogleAuthProvider.credential (
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential != null) {
      Get.toNamed('/main');
    }

    return userCredential;
  }
}
