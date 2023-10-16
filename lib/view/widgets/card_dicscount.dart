import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:pharma_man/model/product_sale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/add_discount_controller.dart';
import '../../controllers/search_name_discount_controller.dart';
import '../../core/const/appcolor.dart';
import 'custom_text.dart';

class CardOfDiscountProduct extends StatelessWidget {
  CardOfDiscountProduct({super.key});
  final SearchNameDiscountController controller =
      Get.put(SearchNameDiscountController());
  final AddDiscountController controller1 = Get.put(AddDiscountController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            height: 80.h,
            child: ListWheelScrollViewX(
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.hardEdge,
              squeeze: 1.01,
              itemExtent: 150,
              diameterRatio: 100.sp,
              children: List.generate(controller.productList.length, (index) {
                return buildCardItems(
                  id: controller.productList[index].id,
                  name: controller.productList[index].productName,
                  price: controller.productList[index].price,
                  date: controller.productList[index].expiryDate,
                  quantity: controller.productList[index].quantity,
                  paracode: controller.productList[index].paracode,
                  index: index.toDouble(),
                  productSale: controller.productList[index],
                  controller: controller,
                  context: context,
                  controller1: controller1,
                );
              }),
            ),
          ),
        ],
      );
      // }
    });
  }
}

Widget buildCardItems({
  int? id,
  String? name,
  int? price,
  String? date,
  String? paracode,
  int? quantity,
  required double index,
  required ProductSale productSale,
  required SearchNameDiscountController controller,
  required AddDiscountController controller1,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 0, right: 0, bottom: 8),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                  color: index % 2 == 0 ? AppColor.color4 : AppColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.5.h),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
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
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                        textAlign: TextAlign.center,
                                        text: '$name',
                                        size: 18,
                                        color: AppColor.grey,
                                        wieght: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                          height: 7.h,
                          width: 9.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(180),
                                  bottomLeft: Radius.circular(180)),
                              color: AppColor.mainColor),
                          child: IconButton(
                            alignment: Alignment.center,
                            onPressed: () async {
                              print(id);
                              SharedPreferences sh =
                                  await SharedPreferences.getInstance();
                              String? userType = sh.getString('type');
                              userType == 'admin'
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: CustomText(
                                            text:
                                                'Enter the discount percentage',
                                            size: 20,
                                            color: AppColor.black,
                                            wieght: FontWeight.w400,
                                          ),
                                          content: Form(
                                            key: controller1.formState,
                                            child: TextFormField(
                                              controller: controller1.discount,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Discount Percentage",
                                                labelStyle: TextStyle(
                                                  color: AppColor.grey,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColor.color4),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColor.mainColor,
                                                      width: 2.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColor.color3,
                                                      width: 1.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    color: AppColor.mainColor),
                                              ),
                                              onPressed: () async {
                                                print(
                                                    controller1.discount.text +
                                                        '-----' +
                                                        id.toString());
                                                controller1.addDiscountProduct(
                                                    controller1.discount.text,
                                                    id.toString());
                                                controller1.discount.clear();
                                                controller.search.clear();
                                                Get.back();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('cancel',
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.mainColor)),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : print('jkghjyhgbujyhgujyhbjbhujyh');
                            },
                            tooltip: 'add discount ',
                            icon: Icon(Icons.discount_rounded),
                            iconSize: 30,
                            color: index % 2 == 0
                                ? AppColor.color4
                                : AppColor.white,
                          )),
                    ),
                  ],
                ),
              ),
            ))
      ],
    ),
  );
}
