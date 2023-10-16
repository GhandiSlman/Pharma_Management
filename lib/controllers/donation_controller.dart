import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_man/core/const/api.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/const/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../model/donation.dart';

class DonationController extends GetxController {
  late final TextEditingController name;
  late final TextEditingController barcode;
  late final TextEditingController quantity;
  late final TextEditingController date;
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> formState2 = GlobalKey<FormState>();
  Future addDonation(
      String name, String barcode, String quantity, String date) async {
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
        SharedPreferences sh = await SharedPreferences.getInstance();
        String? token = sh.getString('signup');
        var headers = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var response = await http.post(Uri.parse('${Api}add-donation'),
            headers: headers,
            body: <String, String>{
              'product_name': name,
              'paracode': barcode,
              'quantity': quantity,
              'expiry_date': date,
            });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.offNamed(AppRoute.allDonation);
        } else {
          isLoading.value = false;
          // Handle login failure
          Get.snackbar(
            'Error',
            'Somthing went wrong wrong',
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

  Future<AllDonation> getAllDonations() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token ${token}');

      final url = Uri.parse('${Api}donations');
      print('token ${token}');
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

        final jsonData = jsonDecode(response.body);

        print('rami ${response.body}');
        isLoading.value = false;
        return AllDonation.fromJson(jsonData);
      }
      throw Exception(
          'Failed to fetch data'); // Add this line to handle non-200 status codes
    } catch (e) {
      print(e.toString());
      Get.snackbar('Erorr', 'somthing went wrong',
          backgroundColor: AppColor.red);
      rethrow; // Re-throw the exception to be caught by FutureBuilder
    }
  }
Future<void> deleteDonation(String id) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}donations/$id/delete');
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
        isLoading.value = true;
        await getAllDonations();
        isLoading.value = false;

        print('Deleted purchase with ID: $id');
      } else {
        throw Exception('Failed to delete purchase');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateDonation(String name, String barcode, String quantity,
      String date, String id) async {
        
          SharedPreferences sh = await SharedPreferences.getInstance();
    String? token = sh.getString('signup');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(Uri.parse('${Api}donations/$id/update'),
        body: <String, String>{
          'product_name': name,
          'paracode': barcode,
          'quantity': quantity,
          'expiry_date': date,
        },
        headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offNamed(AppRoute.allDonation);
    }
        
    
  }

  @override
  void onInit() {
    // TODO: implement onInit
    name = TextEditingController();
    quantity = TextEditingController();
    date = TextEditingController();
    barcode = TextEditingController();
    getAllDonations();
    super.onInit();
  }
}
