import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString translatedText = "Dark Mode Sets".obs;

  void translateText() {
    translatedText.value = translate("dark_mode_setting");
  }
}