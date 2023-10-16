import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/const/api.dart';
import '../core/const/routes.dart';

class EditPurchaseController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late final  TextEditingController?  name;
  late final TextEditingController? netPrice;
  late final TextEditingController? salePrice;
  late final TextEditingController? supplier;
  late final TextEditingController? expiryDate;
  late final TextEditingController? quantity;
  late final TextEditingController? cat;

  final RxString scanResult = RxString('');
  RxBool isLoading = false.obs;

  Future<void> editpurchase(
    String? name,
    String? netPrice,
    String? salePrice,
    String? cat,
    String? supplier,
    String? expiryDate,
    String? quantity,
    String? bar,
    String? purchaseId,
  ) async {
    try {
      var formdata = formState.currentState;
      if (formdata!.validate()) {
        SharedPreferences sh = await SharedPreferences.getInstance();
        String? token = sh.getString('signup');

        var isConnected = await InternetConnectionChecker().hasConnection;

        if (!isConnected) {
          isLoading.value = true;
          Get.snackbar(
            'No internet connection',
            'Please check your internet connection and try again.',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          isLoading.value = false;
        }

        var headers = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var response = await http.post(
            Uri.parse('${Api}update-purchases/${purchaseId}'),
            headers: headers,
            body: <String, String>{
              'name': name!,
             'net_price': netPrice!,
             'salling_price': salePrice!,
             'category': cat!,
             'supplier': supplier!,
             'expiry_date': expiryDate!,
             'quantity': quantity!,
              'paracode': bar!,
            });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // ignore: unused_local_variable
          var responseBody = jsonDecode(response.body);
           Get.offAllNamed(AppRoute.mainScreenAsAdmin);
           isLoading.value = false;
        } else {
          print(response.statusCode);
          isLoading.value = true;
          Get.snackbar(
            'Error',
            'Something went wrong',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Color.fromARGB(255, 245, 113, 103),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() {
    name = TextEditingController();
    netPrice = TextEditingController();
    salePrice = TextEditingController();
    supplier = TextEditingController();
    expiryDate = TextEditingController();
    quantity = TextEditingController();
    cat = TextEditingController();
    super.onInit();
  }
}
