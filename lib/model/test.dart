import 'package:get/get.dart';

class MyController extends GetxController {
 

  RxString scannedValue = RxString('');

  void updateText(String value) {
    scannedValue.value = value;
  }
}