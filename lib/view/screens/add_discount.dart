import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/barcode_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/view/widgets/custom_icon_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_form.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/search_baracode_controller.dart';
import '../../controllers/search_name_discount_controller.dart';
import '../widgets/card_dicscount.dart';


class AddDiscount extends StatelessWidget {
  // CustomerController controller = Get.put(CustomerController());
  final SearchNameDiscountController controller = Get.put(SearchNameDiscountController());
  final BacodeController controller1 = Get.put(BacodeController());
  final SearchBaracodeController controller2 =
      Get.put(SearchBaracodeController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
          padding: EdgeInsets.only(left: 3.h, right: 1.h),
          child: Form(
            key: controller.formState4,
            onChanged: controller.productList.clear,
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomText(
                        text: 'add discount',
                        size: 15.sp,
                        wieght: FontWeight.bold,
                        color: AppColor.color1),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            // height: 10.h,
                            width: 90.w,
                            child: CustomTextForm(
                              hint: 'search ',
                              icon: Icons.search,
                              onChanged: controller.onSearchTextChanged,
                              mycontroller: controller.search,
                            )),
                      ],
                    ),
                  
                    CardOfDiscountProduct()
                  ],
                ),
              ],
            ),
          )),
     
    );
  }
}
