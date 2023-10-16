import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/api.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class LogOutController extends GetxController {
  RxBool isLoading = false.obs;
  Future logOut() async {
    isLoading.value = true;
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
     
      if (token != null) {
        var response = await http.get(Uri.parse('${Api}logout'), headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          sh.remove('signup');
          isLoading.value = false;
          Get.offNamed(AppRoute.login);
          // Get.snackbar('Success', 'Logged out successfully',
          //     padding: const EdgeInsets.all(10),
          //     backgroundColor: Colors.green,
          //     snackPosition: SnackPosition.TOP);
        } else {
          isLoading.value = false;
          Get.snackbar('Error', 'Something went wrong',
              padding: EdgeInsets.all(2.h),
              backgroundColor: Color.fromARGB(255, 245, 113, 103),
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Token not found',
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }
}
