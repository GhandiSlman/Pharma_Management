import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/view/widgets/snackbar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/const/api.dart';
import '../core/const/routes.dart';

class EditSuppliersController extends GetxController {
  //GlobalKey<FormState> formState = GlobalKey<FormState>();
  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController address;
  late final TextEditingController company;
  late final TextEditingController description;
  late final TextEditingController email;

  RxBool isLoading = false.obs;

  Future<void> editSuppliers(
    String name,
    String phone,
    String address,
    String company,
    String description,
    String email,
    String supId,
  ) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print(token);
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

      var response = await http.post(
          Uri.parse('${Api}Update-supplier/${supId}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          },
          body: <String, String>{
            'name': name,
            'phone': phone,
            'address': address,
            'company': company,
            'description': description,
            'email': email,
          });
      print(response.statusCode);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: unused_local_variable
        print('dafsdfasdg'); 
        {
          Get.offNamed(AppRoute.allsuppliers);
          isLoading.value = false;
        }
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
    phone = TextEditingController();
    address = TextEditingController();
    company = TextEditingController();
    description = TextEditingController();
    email = TextEditingController();

    super.onInit();
  }
}
