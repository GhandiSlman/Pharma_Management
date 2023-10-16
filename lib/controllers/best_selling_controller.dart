import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/model/best_selling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/const/api.dart';
import 'package:http/http.dart' as http;

class BestSellingController extends GetxController {
  var productList = <BestSelling>[].obs;
  var isLoading = true.obs;
  RxString title = ''.obs;
  @override
  onInit() {
    getProducts();
    super.onInit();
  }

  static Future<List<BestSelling>> getProduct() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? token = sh.getString('signup');

    var url = Uri.parse('${Api}Best-Selling');
    print(token);
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var jsonData = response.body;
      return bestSellingFromJson(jsonData);
    } else {
      return throw Exception("Failed to load product");
    }
  }

  Future getProducts() async {
    try {
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
      var products = await getProduct();

      if (products.isNotEmpty) {
        productList.addAll(products);
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
