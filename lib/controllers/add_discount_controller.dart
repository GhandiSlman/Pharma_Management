import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/const/api.dart';
import '../view/widgets/snackbar.dart';

class AddDiscountController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late final TextEditingController discount;

  Future<void> addDiscountProduct(
    String discount,
    String id,
  ) async {
    try {
      var formdata = formState.currentState;
      if (formdata!.validate()) {
        SharedPreferences sh = await SharedPreferences.getInstance();
        String? token = sh.getString('signup');
        print(token);
        var isConnected = await InternetConnectionChecker().hasConnection;

        if (!isConnected) {
          
          Get.snackbar(
            'No internet connection',
            'Please check your internet connection and try again.',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        }

        var response = await http
            .post(Uri.parse('${Api}add-discount'), headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }, body: <String, String>{
          'product_id': id,
          'discount': discount,
        });
        print(response.statusCode);
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // ignore: unused_local_variable
          print('done');
          // ignore: unused_local_variable
          var responseBody = jsonDecode(response.body);
          showNotificationSnackbar('Hi','Discount added');
          
        } else {
          print(response.statusCode);
          
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
    discount = TextEditingController();

    super.onInit();
  }
}
