import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:sizer/sizer.dart';

import '../../core/const/api.dart';

class ForgetPassController extends GetxController {
  late final TextEditingController email;
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future sendEmail(String email) async {
   
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
            .post(Uri.parse('${Api}password/forget'), body: <String, String>{
          'email': email,
        });
        print(response.statusCode);
        Get.toNamed(AppRoute.checkCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // ignore: unused_local_variable
          Map responseBody = jsonDecode(response.body);
          isLoading.value = false;
          Get.snackbar('Success', 'We send a code to your email',
              padding:  EdgeInsets.all(2.h),
              backgroundColor: Color.fromARGB(255, 153, 247, 156),
              snackPosition: SnackPosition.TOP);
        } else {
          isLoading.value = false;
          Get.snackbar('Error', 'Something went wrong',
        padding: EdgeInsets.all(2.h),
              backgroundColor: Color.fromARGB(255, 245, 113, 103),
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } catch (e) {
      print(e); 
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }
}
