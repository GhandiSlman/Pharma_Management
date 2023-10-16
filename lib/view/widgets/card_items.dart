
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:pharma_man/controllers/best_selling_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/view/screens/product_details.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CardItems extends StatelessWidget {
  CardItems({Key? key}) : super(key: key);
  final BestSellingController controller = Get.put(BestSellingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.productList.isEmpty){
          return Column(
            children: [
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
          );

      }
      else if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 130),
          child: CircularProgressIndicator(
            color: AppColor.color1,
          ),
        );
      } else {
        return Column(
          children: [
            CustomText(text: 'Best Selling Products', size: 25, wieght: FontWeight.normal, color: AppColor.black ,fontFamily: 'Pacifico',),
            Container(
              height:37.h,
              width: MediaQuery.of(context).size.width,
              child: ListView(
             
                scrollDirection: Axis.horizontal,
                // squeeze: 1.5,
                // offAxisFraction: -0.01,
                itemExtent: 200,
              //   diameterRatio: 0.7, 
                children: List.generate(controller.productList.length, (index) {
                  return buildCardItems(
                    name: controller.productList[index].productName,
                    ontap: () {
                      Get.to(
                        () => ProductDetails(
                          product: controller.productList[index],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        );
      }
    });
  }
}

Widget buildCardItems({
  required String name,
  required Function() ontap,
}) {
  return 
      
        Padding(
          padding: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 10),
          child: InkWell(
            onTap: ontap,
            child: Container(
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                 boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
                borderRadius: BorderRadius.circular(15),
                color: AppColor.white,
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 25.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      Image.asset('assets/images.jpeg')
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: CustomText(
                        textAlign: TextAlign.center,
                        text: name,
                        size: 20,
                        color: AppColor.black,
                        wieght: FontWeight.w900,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
