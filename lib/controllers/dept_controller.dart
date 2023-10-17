import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/routes.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/const/api.dart';
import '../model/dept.dart';

class DebtController extends GetxController {
  late final TextEditingController name;
  late final TextEditingController value;

  RxBool isLoading = false.obs;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> formState2 = GlobalKey<FormState>();
  

  Future addDebt(String name, String value) async {
    try {
      var formdata = formState.currentState;
      if (formdata!.validate()) {
        SharedPreferences sh = await SharedPreferences.getInstance();
        String? token = sh.getString('signup');
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
        var headers = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        // Internet connection available, proceed with login
        isLoading.value = true;
        var response = await http.post(
          Uri.parse('${Api}add-a-debt'),
          body: <String, String>{
            'customer_name': name,
            'debt_value': value,
          },
          headers: headers,
        );
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.offAllNamed(AppRoute.mainScreenAsAdmin);
          isLoading.value = true;
          // getAllDebt();
          isLoading.value = false;
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
      Get.snackbar('Error', 'An error occurred');
      print(e);
    }
  }

  getToken(String token) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setString('signup', token);
  }

  Future<AllDebt> getAllDebt() async {
    
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}get-debt');
      print('token${token}');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);

        var jsonData = jsonDecode(response.body);
        isLoading.value = false;

        return AllDebt.fromJson(jsonData);
      }
      throw Exception('Failed to fetch data');
    
  }

  Future updateDebt(String debtValue, String id) async {
 
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse('${Api}debt-update/$id'),
          body: <String, String>{
            'debt_value': debtValue,
          },
          headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offAllNamed(AppRoute.mainScreenAsAdmin);
        isLoading == true;
        //getAllDebt();
        isLoading == false;
      
    }
  }

  Future<void> deleteDebt(String id) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}debt-delete/$id');
      print('token${token}');
      var response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offAllNamed(AppRoute.mainScreenAsAdmin);
        isLoading.value = true;
        //getAllDebt();
        isLoading.value = false;

        print('Deleted purchase with ID: $id');
      } else {
        throw Exception('Failed to delete purchase');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    name = TextEditingController();
    value = TextEditingController();
    // getAllDebt();
    // role_id = 1;
    super.onInit();
  }

  // void loginAsAdmin() {

  //     isLoggedIn.value = true;
  //     isAdmin.value = true;

  // }

  // void loginAsUser() {

  //     isLoggedIn.value = true;
  //     isAdmin.value = false;

  // }
}
