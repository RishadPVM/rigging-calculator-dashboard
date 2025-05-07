import 'package:get/get.dart';

class CraneController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final RxBool showAddButton = false.obs;

  void updateTabIndex(int index) {
    tabIndex.value = index;
    showAddButton.value = index == 1 || index == 2;
  }
}
