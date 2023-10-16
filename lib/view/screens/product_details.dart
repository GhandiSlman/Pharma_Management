import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/model/best_selling.dart';
import 'package:pharma_man/model/product_sale.dart';
import 'package:pharma_man/view/widgets/custom_back.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/search_name_controller.dart';



class ProductDetails extends StatelessWidget {
  final BestSelling product;
  final ProductSale? productSale;
   ProductDetails({
    required this.product,
    this.productSale,
    Key? key,
  }) : super(key: key);
  final SearchNameController controller = Get.put(SearchNameController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        padding: EdgeInsets.all(3.h),
        child: ListView(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(
                  height: 1.h,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomBack(),
                 
                  
                  ],
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset('assets/images.jpeg')
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: product.productName,
                    size: 40,
                    fontFamily: 'Pacifico',
                    color: AppColor.black,
                    wieght: FontWeight.w400,
                    overflow: TextOverflow.fade,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                SizedBox(height: 5.h,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.color1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomText(
                        text: 'quantity : ${product.quantity} ',
                        size: 20,
                        color: AppColor.white,
                        wieght: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.color1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomText(
                        text:
                            'Selling quantity : ${product.selling_quantity}',
                        size: 20,
                        color: AppColor.white,
                        wieght: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.color1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomText(
                        text: 'Price : ${product.price}\$ ',
                        size: 20,
                        overflow: TextOverflow.ellipsis,
                        color: AppColor.white,
                        wieght: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.color1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                 
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
