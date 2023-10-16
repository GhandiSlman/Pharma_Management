import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/routes.dart';

import 'package:http/http.dart' as http;
import 'package:pharma_man/view/screens/main_screen_as_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/const/api.dart';
import '../../view/screens/main_sceeen_as_user.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  var userType = ''.obs;
  // late final int role_id;
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isAdmin = false.obs;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  //MyServices myServices = Get.find();

  bool isshowpass = true;
  isShowPass() {
    isshowpass = isshowpass == true ? false : true;
    update();
  }

  goToForgetPass() {
    Get.toNamed(AppRoute.forgetPass);
  }

  Future login(String email, String password) async {
    try {
      var formdata = formState.currentState;
      if (formdata!.validate()) {
        isLoading.value = true;
        // Check for internet connection
        var isConnected = await InternetConnectionChecker().hasConnection;

        if (!isConnected) {
          // Handle no internet connection
          isLoading.value = false;
          Get.snackbar(
            'No internet connection',
            'Please check your internet connection and try again.',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        // Internet connection available, proceed with login
        isLoading.value = true;
        var response =
            await http.post(Uri.parse('${Api}login'), body: <String, String>{
          'email': email,
          'password': password,
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
        //  myServices.sh.setString('logi', '1');

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

          // Get.snackbar('Success', 'Done',
          //     padding: const EdgeInsets.all(10),
          //     backgroundColor: Colors.green,
          //     snackPosition: SnackPosition.TOP);
        } else {
          isLoading.value = false;
          // Handle login failure
          Get.snackbar(
            'Email or password',
            'Your information is wrong',
            padding: EdgeInsets.all(2.h),
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      // Handle any exceptions
      Get.snackbar('Error', 'An error occurred');
      print(e);
    }
  }

  goToSignUp() {
    Get.offNamed(AppRoute.signup);
  }

  getToken(String token) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setString('signup', token);
  }

  // getRoleId(int role_id) async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   await sh.setInt('login', role_id);
  // }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
   // role_id = 1;
    super.onInit();
  }

  void loginAsAdmin() {
   
      isLoggedIn.value = true;
      isAdmin.value = true;
    
  }
void loginAsUser() {
  
      isLoggedIn.value = true;
      isAdmin.value = false;
    
  }
}
