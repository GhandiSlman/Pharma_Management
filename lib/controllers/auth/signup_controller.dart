import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_man/view/screens/main_screen_as_admin.dart';

import 'package:sizer/sizer.dart';
import '../../core/const/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/screens/main_sceeen_as_user.dart';

class SignUpController extends GetxController {
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController conPassword;
  
  var userType = ''.obs;
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  void setUserType(String type) {
    userType.value = type;
  }
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  Future signUp(
      String name, String email, String password, String conPass) async {
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
        var response =
            await http.post(Uri.parse('${Api}register'), body: <String, String>{
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': conPass,
          'type' : userType.value,
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          isLoading.value = false;
          getToken(responseBody['token']);
          SharedPreferences sh = await SharedPreferences.getInstance();

          // String userType = sh.getString('type') ?? '';

          sh.setString('type', userType.value);
          if (userType.value == 'admin') {
            Get.offAll(MainScreenAsAdmin());
          } else if (userType.value == 'user') {
            Get.offAll(MainScreenAsUser());
          }
          print('================${responseBody['token']}');
         // Get.offNamed(AppRoute.mainScreen);
          // Get.snackbar('Success', 'Done',
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
      }
    } catch (e) {
      print(e);
    }
  }

  getToken(String token) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setString('signup', token);
  }

  RxString passwordd = ''.obs;
  RxString confirmPassword = ''.obs;

  void onPasswordChanged(String value) {
    passwordd.value = value;
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword.value = value;
  }

  String? validateConfirmPassword(String value) {
    if (passwordd.value != confirmPassword.value) {
      return "Password dosn't not match";
    }
    return null;
  }
@override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    conPassword = TextEditingController();
    // Get.put(LoginController());
    super.onInit();
  }
}
