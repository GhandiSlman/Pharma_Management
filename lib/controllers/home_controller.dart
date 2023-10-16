import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/const/api.dart';
import '../model/product.dart';

import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;

  @override
  onInit() {
    getProducts();
    super.onInit();
  }

  static Future<List<Product>> getProduct() async {
    var url = Uri.parse('$BaseURL/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productFromJson(jsonData);
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
