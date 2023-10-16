import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_man/view/screens/customer1.dart';
import 'package:pharma_man/view/screens/get_invoice.dart';
import 'package:pharma_man/view/screens/home_as_admin.dart';
import 'package:pharma_man/view/screens/home_as_user.dart';
import '../view/screens/dept.dart';
import '../view/screens/main_sale.dart';

class MainController extends GetxController {
 
// RxInt currentIndexNav = 0.obs;
  RxInt currentIndexCarousel = 0.obs;
// Widget getSelectedWidget({required int index}) {
//   Widget widget;
//   switch (index) {
//     case 0:
//       widget = HomePage();
//       break;
//     case 1:
//       widget = const DebtScreen();
//       break;
//     case 2:
//       widget = const GetSuppliersScreen();
//       break;
//     case 3:
//       widget = const AlarmScreen();
//       break;
//     default:
//       widget = HomePage();
//       break;
//   }
//   return widget;
// }
  final List<Widget> pages = [
    HomeAsAdmin(),
    Customer1(),
    GetInvoiceScreen(),
    DebtScreen(),
    // AlarmScreen(),
  ];
  final List<Widget> pages2 = [
    HomeAsUser(),
    Customer1(),
    GetInvoiceScreen(),
    // AlarmScreen(),
  ];
  final selectedIndex = RxInt(0);
}
