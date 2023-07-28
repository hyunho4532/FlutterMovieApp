import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {

  // Get.fine 대신 클래스명 사용 가능
  static BottomNavigationBarController get to => Get.find();

  // 현재 선택된 탭 아이템 번호 저장
  final RxInt selectedIndex = 0.obs;

  // 탭 이벤트가 발생할 시 selectedIndex 값을 변경해줄 함수
  void changeIndex(int index) {
    selectedIndex(index);
  }
}