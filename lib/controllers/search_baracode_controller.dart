import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/const/api.dart';

import 'package:http/http.dart' as http;

import '../model/product_sale.dart';
import '../view/widgets/snackbar.dart';

class SearchBaracodeController extends GetxController {

 var productList = <ProductSale>[].obs;
  RxMap productsMap = <ProductSale, int>{}.obs;
  var isLoading = true.obs;
  RxString title = ''.obs;
  GlobalKey<FormState> formState4 = GlobalKey<FormState>();
  late final TextEditingController search;
  final _searchDebounce = Debouncer(delay: Duration(milliseconds: 2000));
 
  void onSearchBaracodeChanged(String searchBaracode) {
    _searchDebounce(() {
      getProducts(searchBaracode);
    });
  }

  static Future<List<ProductSale>> getProduct(String baracode) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? token = sh.getString('signup');

    var url = Uri.parse('${Api}products/$baracode');
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
      return productFromJson(jsonData);
    } else if (response.statusCode == 202) {
      showNotificationSnackbar('Hi', 'there is no result');
      return throw Exception('there is no result');
    } else
      return throw Exception("Failed to load product");
  }

  Future getProducts(String searchBaracode) async {
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
      var products = await getProduct(searchBaracode);
      productList.clear();
      if (products.isNotEmpty) {
        productList.addAll(products);
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
   // ignore: unused_element
   void addProduct(ProductSale productSale) {
    if (productsMap.containsKey(productSale)) {
     productsMap[productSale] = productsMap[productSale]! + 1;
     productsMap.refresh();

    } else {
      productsMap[productSale] = 1;
    }
  }

  void removeAllSameTypeProducts(ProductSale productSale) {
    if (productsMap.containsKey(productSale) &&
        productsMap[productSale] != null &&
        productsMap[productSale] == 1) {
      productsMap.removeWhere((key, value) => key == productSale);
    } else {
      productsMap[productSale] -= 1;
    }
  }

  void removeOneItem(ProductSale productSale) {
    productsMap.removeWhere((key, value) => key == productSale);
  }

  void clearAll() {
    productsMap.clear();
  }
  }
  get productSubTotalPrice =>
      productsMap.entries.map((e) => e.key.price * e.value).toList();
  get prouctTotlalPrice => productsMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element);

   

 @override
  void onInit() {
    search = TextEditingController();

    super.onInit();
  }

  void addProduct(ProductSale productSale) {}

}
