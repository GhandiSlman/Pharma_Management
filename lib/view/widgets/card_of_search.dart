import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:pharma_man/model/product_sale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/search_name_controller.dart';
import '../../core/const/appcolor.dart';
import '../../core/const/routes.dart';
import 'custom_text.dart';

class CardOfSearchProduct extends StatelessWidget {
  CardOfSearchProduct({super.key});
  final SearchNameController controller = Get.put(SearchNameController());

  @override
  Widget build(BuildContext context) {
    return 
    Obx(() {
      return Container(
        height: 60.h,
     
        child: 
          
            ListView(
              
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 30,bottom: 30),
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.hardEdge,
             // squeeze: 1.01,
              itemExtent: 180,
            //  diameterRatio: 100.sp,
              children: List.generate(controller.productList.length, (index) {
                return Row(
                  children: [
  
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        buildCardItems(
                          id: controller.productList[index].id,
                          id1: controller.productList[index].id,
                          name: controller.productList[index].productName,
                          price: controller.productList[index].price,
                          date: controller.productList[index].expiryDate,
                          quantity: controller.productList[index].quantity,
                          paracode: controller.productList[index].paracode,
                          index: index.toDouble(),
                          productSale: controller.productList[index],
                          controller: controller,
                        ),
                      ],
                    ),
                 //   IconButton(onPressed: (){print('kmbd-----------------------');}, icon: Icon(Icons.add)),
                  ],
                );
              }),
           
        ),
      );

      // }
   });
  }
}
class buildCardItems extends StatelessWidget {
  final int? id;
  int? id1;
  String? name;
  int? price;
  String? date;
  String? paracode;
  int? quantity;
  double index;
  ProductSale productSale;
  SearchNameController controller;

  buildCardItems({
    Key? key,
    this.id,
    this.id1,
    this.name,
    this.price,
    this.date,
    this.paracode,
    this.quantity,
    required this.index,
    required this.productSale,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
        // Stack(
        //   children: [

        Row(

      children: [
      SizedBox(width: 10,),
        SizedBox(
          width: 270,
          child: Container(
            // width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
              color: index % 2 == 0 ? AppColor.color4 : AppColor.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child:

                Container(
                    height: 8.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(180),
                            bottomLeft: Radius.circular(180)),
                        color: AppColor.mainColor),
                    child: Center(
                      child: IconButton(
                        //  alignment: Alignment.center,
                        onPressed: () async {
                          print('=======================================');
                          Future<void> saveValue(
                              String key, String value) async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString(key, value);
                          }

                          controller.addProduct(productSale);
                          String productId = id.toString();
                          await saveValue('key1', productId);

                          String productId1 = id1.toString();
                          await saveValue('key2', productId1);

                          Get.toNamed(AppRoute.slaesScreen);
                          controller.search.clear();
                        },
                        tooltip: 'add to cart',
                        icon: Icon(Icons.add),
                        iconSize: 30,
                        color:
                            index % 2 == 0 ? AppColor.color4 : AppColor.white,
                      ),
                    ))),
              ],
            ),
          ),
        ),
      ],
    );

    //   ],
    // ),
  }
}
