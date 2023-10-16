import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:sizer/sizer.dart';


import 'package:http/http.dart' as http;

import '../../core/const/api.dart';
import '../../core/const/routes.dart';

class CheckCodeController extends GetxController {
  late final TextEditingController password;
  late final TextEditingController conPassword;
  late final TextEditingController code;
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future enterCode(String code, String password, String conPassword) async {
    
    try {
      var formdata = formState.currentState;
      if (formdata!.validate()) {
        isLoading.value = true;
        // Check for internet connection
        var isConnected = await InternetConnectionChecker().hasConnection;

        if (!isConnected) {
        
          Get.snackbar(
            'No internet connection',
            'Please check your internet connection and try again.',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
            isLoading.value = false;
          return;
        }
        isLoading.value = true;
        var response = await http
            .post(Uri.parse('${Api}password/reset'), body: <String, String>{
          'code': code,
          'password': password,
          'password_confirmation': conPassword,
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // ignore: unused_local_variable
          Map responseBody = jsonDecode(response.body);
          isLoading.value = false;
          Get.offAllNamed(AppRoute.login);
          Get.snackbar('Success', 'Reset password successfully',
              padding:  EdgeInsets.all(2.h),
              backgroundColor: Color.fromARGB(255, 153, 247, 156),
              snackPosition: SnackPosition.TOP);
        } else {
          isLoading.value = false;
          Get.snackbar('Error', 'Wrong Code',
             padding: EdgeInsets.all(2.h),
              backgroundColor: Color.fromARGB(255, 245, 113, 103),
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } catch (e) {
      print(e);
    }
  }
  var passwordd = ''.obs;
  var confirmPassword = ''.obs;

  void onPasswordChanged(String value) {
    passwordd.value = value;
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword.value = value;
  }

  String? validateConfirmPassword() {
    if (passwordd.value != confirmPassword.value) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onInit() {
    password = TextEditingController();
    conPassword = TextEditingController();
    code = TextEditingController();
    super.onInit();
  }
}
