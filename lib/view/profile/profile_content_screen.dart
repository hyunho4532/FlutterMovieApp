import 'package:dark_light_button/dark_light_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:movie_app_project/controller/language/language_controller.dart';
import 'package:movie_app_project/view/profile/profile_screen.dart';
import 'package:movie_app_project/view/register/register_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileContentScreen extends StatefulWidget {
  late ValueNotifier<ThemeMode> themeNotifier;

  ProfileContentScreen({Key? key, required this.themeNotifier})
      : super(key: key);

  @override
  State<ProfileContentScreen> createState() => _ProfileContentScreenState();
}

class _ProfileContentScreenState extends State<ProfileContentScreen> {
  int _currentIndex = 1;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 48.0),
            child: Text(
              '프로필 화면',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: SizedBox(
              width: 350,
              height: 80,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        '다크 모드 설정',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ToggleSwitch(
                        minWidth: 90.0,
                        initialLabelIndex: _currentIndex,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: const ['Dark', 'Light'],
                        icons: const [Icons.nightlight, Icons.sunny],
                        activeBgColors: const [
                          [Colors.black],
                          [Colors.yellow]
                        ],
                        onToggle: (index) {
                          setState(() {
                            _currentIndex = index!;
                          });

                          if (index == 0) {
                            widget.themeNotifier.value = ThemeMode.dark;
                          } else {
                            widget.themeNotifier.value = ThemeMode.light;
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(content: Builder(
                          builder: (context) {
                            return SizedBox(
                              height: 160,
                              width: 190,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      '정말로 계정을 삭제하시겠습니까?',
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 16.0, left: 2.0),
                                    child: Text(
                                      '계정을 삭제하시면 영원히 복구하실 수 없습니다',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 36.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          onDeleteAccount();
                                        },
                                        child: const Text(
                                          '탈퇴 완료',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )));
              },
              child: SizedBox(
                width: 350,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        '이메일 설정',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      _auth.currentUser!.email.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Card(
            child: SizedBox(
              width: 350,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '언어 설정',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onDeleteAccount() {
    try {
      _auth.currentUser!.delete();

      Get.to(const RegisterScreen());

      Get.snackbar('알림', '계정이 삭제되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
          colorText: Colors.black
      );
    } catch (e) {
      print('$e 에러가 발생해서 계정이 삭제되지 않았습니다.');

      Get.to(const ProfileScreen());
    }
  }
}
