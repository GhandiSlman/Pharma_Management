import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pharma_man/view/widgets/card_expired_product.dart';

import '../../controllers/get_expired_controller.dart';
import '../../core/const/appcolor.dart';
import '../widgets/custom_text.dart';

class ExpiredProducts extends StatelessWidget {
   ExpiredProducts({super.key});
  final ExpiredProductController controller =
      Get.put(ExpiredProductController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
body: SingleChildScrollView(
  child:   Column(
  
    children: [
       CardExpired()
  
    ],
  
  ),
)


    ));
  }
}
