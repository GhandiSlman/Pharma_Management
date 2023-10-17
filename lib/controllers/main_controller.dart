import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_man/view/screens/search_for_sale.dart';
import 'package:pharma_man/view/screens/get_invoice.dart';
import 'package:pharma_man/view/screens/home_as_admin.dart';
import 'package:pharma_man/view/screens/home_as_user.dart';
import '../view/screens/dept.dart';


class MainController extends GetxController {
 

  RxInt currentIndexCarousel = 0.obs;

  final List<Widget> pages = [
    HomeAsAdmin(),
    SearchForSale(),
    GetInvoiceScreen(),
    DebtScreen(),
  ];
  final List<Widget> pages2 = [
    HomeAsUser(),
    SearchForSale(),
    GetInvoiceScreen(),

  ];
  final selectedIndex = RxInt(0);
}
