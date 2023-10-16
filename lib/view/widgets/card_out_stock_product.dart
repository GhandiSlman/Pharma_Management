import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/get_out_stock_product_controller.dart';
import '../../core/const/appcolor.dart';
import 'custom_text.dart';

class CardOutStockProduct extends StatelessWidget {
  CardOutStockProduct({Key? key}) : super(key: key);
  final OutStockProductController controller =
      Get.put(OutStockProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.outProductList.isEmpty) {
        return Center(
          child: Column(
            
            mainAxisSize: MainAxisSize.min, 
            children: [
              SizedBox(height: 45.h),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomText(
                  text: '',
                  size: 30,
                  color: AppColor.mainColor,
                  wieght: FontWeight.w700,
                  
                ),
              ),
            ],
          ),
     );
      } else if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 130),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColor.color1,
            ),
          ),
        );
      } else {
        return Container(
          height: 100.h,
          width: MediaQuery.of(context).size.width,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.vertical,
            squeeze: 1.01,
            offAxisFraction: -0.01,
            itemExtent: 200,
            diameterRatio: 3,
            children:
                List.generate(controller.outProductList.length, (index) {
              return buildCardItems(
                  name: controller.outProductList[index].productName,
                  price: controller.outProductList[index].price,
                  date: controller.outProductList[index].expiryDate,
                  quantity: controller.outProductList[index].quantity,
                  paracode: controller.outProductList[index].paracode);
            }),
          ),
        );
      }
    });
  }
}

Widget buildCardItems({
  String? name,
  int? price,
  String? date,
  String? paracode,
  int? quantity,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 16.5.h,
            // width: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              child: Container(
                width: 200.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.white,
                ),
                child: Column(children: [
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.label,
                        color: AppColor.mainColor,
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: AppColor.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.black.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            CustomText(
                                text: 'Name:  ',
                                size: 19,
                                wieght: FontWeight.w700,
                                color: AppColor.black),
                            CustomText(
                              textAlign: TextAlign.center,
                              text: '$name',
                              size: 18,
                              color: AppColor.grey,
                              wieght: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.attach_money,
                        color: AppColor.mainColor,
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.black.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            CustomText(
                                text: 'Price:  ',
                                size: 19,
                                wieght: FontWeight.w700,
                                color: AppColor.black),
                            CustomText(
                              textAlign: TextAlign.center,
                              text: '${price ?? 'N/A'}\$',
                              size: 18,
                              color: AppColor.grey,
                              wieght: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.inventory,
                        color: AppColor.mainColor,
                      ),
                      SizedBox(width: 1.h),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.black.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            CustomText(
                                text: 'Quantity:  ',
                                size: 19,
                                wieght: FontWeight.w700,
                                color: AppColor.black),
                            CustomText(
                              textAlign: TextAlign.center,
                              text: '${quantity ?? 'N/A'}',
                              size: 18,
                              color: AppColor.grey,
                              wieght: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.barcode_reader,
                        color: AppColor.mainColor,
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.black.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            CustomText(
                                text: 'Baracode:  ',
                                size: 19,
                                wieght: FontWeight.w700,
                                color: AppColor.black),
                            CustomText(
                              textAlign: TextAlign.center,
                              text: '${paracode}',
                              size: 18,
                              color: AppColor.grey,
                              wieght: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                ]),
              ),
            ))
      ],
    ),
  );
}
//....................................................................













