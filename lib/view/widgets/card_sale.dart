import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/search_name_controller.dart';
import '../../core/const/appcolor.dart';
import '../../model/product_sale.dart';
import 'custom_text.dart';

class CardSaleProduct extends StatelessWidget {
  CardSaleProduct({
    required this.index,
    required this.productSale,
    required this.counter,
    Key? key,
  }) : super(key: key);

  final int index;
  final ProductSale productSale;
  final int counter;
  final SearchNameController controller = Get.put(SearchNameController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 10, right: 10),
        child: Card(
          color: AppColor.color4,
          elevation: 12.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '${productSale.productName}',
                  size: 18,
                  color: AppColor.black,
                  wieght: FontWeight.bold,
                ),
                Divider(
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_money,
                            color: AppColor.mainColor, size: 20),
                        SizedBox(width: 1.5.w),
                        CustomText(
                          text: '${productSale.price ?? 'N/A'}\$',
                          size: 17,
                          wieght: FontWeight.normal,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'Quantity ',
                          size: 15,
                          color: AppColor.mainColor,
                          wieght: FontWeight.normal,
                        ),
                        SizedBox(width: 1.5.w),
                        CustomText(
                            text: '${productSale.quantity ?? 'N/A'}',
                            size: 17,
                            color: AppColor.black,
                            wieght: FontWeight.normal),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'Subtotal ',
                          size: 15,
                          color: AppColor.mainColor,
                          wieght: FontWeight.normal,
                        ),
                        CustomText(
                          text:
                              '${controller.productSubTotalPrice[index] ?? 'N/A'}\$',
                          size: 17,
                          color: AppColor.black,
                          wieght: FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 10.w),
                    IconButton(
                      onPressed: () {
                        controller.removeAllSameTypeProducts(productSale);
                      },
                      icon: Icon(Icons.remove_circle, color: AppColor.grey),
                      tooltip: "Remove one more of this product",
                    ),
                    Text(
                      '$counter',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.grey),
                    ),
                    IconButton(
                      onPressed: () {
                        if (counter < productSale.quantity!.toInt()) {
                          controller.addProduct(productSale);
                        } else {
                          print('quntity = counter');
                        }
                      },
                      icon: Icon(Icons.add_circle, color: AppColor.mainColor),
                      tooltip: "Add one more of this product",
                    ),
                    SizedBox(width: 23.w),
                    IconButton(
                      onPressed: () {
                        controller.removeOneItem(productSale);
                      },
                      icon: Icon(Icons.delete_forever, color: AppColor.red),
                      tooltip: "Remove all of this product",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
