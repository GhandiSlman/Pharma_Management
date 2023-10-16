import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:sizer/sizer.dart';

import '../../controllers/all_purchase_controller.dart';
import '../../core/const/appcolor.dart';
import '../../core/const/routes.dart';
import '../../model/purchase.dart';
import '../widgets/card_purchase.dart';
import '../widgets/custom_floating_button.dart';
import '../widgets/custom_text.dart';

class GetInvoiceScreen extends StatelessWidget {
  GetInvoiceScreen({this.purchases, Key? key}) : super(key: key);
  final AllPurchaseController controller = Get.put(AllPurchaseController());
  final Purchases? purchases;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      floatingActionButton: CustomFloatingButton(
        icon: Icon(Icons.add),
        color: AppColor.color1,
        onPressed: () {
          Get.toNamed(AppRoute.addpurchase);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
                  child: CircularProgressIndicator(
                color: AppColor.color1,
              ));
        } else {
          return Container(
            padding: EdgeInsets.all(3.h),
            child: Column(
              children: [
                CardPurchase(),
              ],
            ),
          );
        }
      }),
    );
  }
}
