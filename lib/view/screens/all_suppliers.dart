import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:pharma_man/view/widgets/card_supplier.dart';
import 'package:sizer/sizer.dart';

class AllSuppliers extends StatelessWidget {
  const AllSuppliers({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [CustomText(text: 'All suppliers', size: 28, wieght: FontWeight.w600, color: AppColor.mainColor)],),
              SizedBox(
                height: 2.2.h,
              ),
              CardSupliers(),
            ],
          ),
        ),
        // floatingActionButton:
        //     FloatingActionButton(backgroundColor: AppColor.color4,onPressed: () =>Get.offAllNamed(AppRoute.mainScreenAsAdmin), child: Icon(Icons.arrow_circle_right_rounded,color: AppColor.mainColor,size: 30,)),
      ),
    );
  }
}
