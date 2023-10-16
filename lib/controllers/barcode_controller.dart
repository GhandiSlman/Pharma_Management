import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BacodeController extends GetxController {
  RxString? barcode = ''.obs;
  String scannedBarcode = '';
  RxString scannedValue = RxString('');
  late TextEditingController ?barCode = TextEditingController();
  @override
  void onInit() {
    barcode!.value.toString();
    barCode = TextEditingController();
    //barcode.value=barCode.text;
    super.onInit();
  }

  Future<void> scanBarcode() async {
    try {
      scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
          '#2011CF', 'cancel', true, ScanMode.BARCODE);

      barcode!.value = scannedBarcode;
    } catch (e) {
      barcode!.value = 'unable to read this ';
    }
     if (barcode!.value != '-1') {
    barCode!.text =barcode!.value.toString();                                     
        }
  }
}
