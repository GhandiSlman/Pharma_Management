import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/add_invoice_controller.dart';
import '../../controllers/search_baracode_controller.dart';
import '../../controllers/search_name_controller.dart';
import '../../model/product_sale.dart';
import '../widgets/card_sale.dart';

class SalesScreen extends StatelessWidget {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  SalesScreen({this.productSale, Key? key}) : super(key: key);
  final ProductSale? productSale;

  Future<String?> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  final SearchNameController controller = Get.put(SearchNameController());
  final AddInvoiceController controllerInvoice =
      Get.put(AddInvoiceController());

  final SearchBaracodeController controller2 =
      Get.put(SearchBaracodeController());

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // var idProduct1 = args['key1'];
    // var idProduct2 = args['key2'];
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (controller.productsMap.isEmpty) {
            return Center(
              child: CustomText(
                text: 'The Cart Is Empty',
                size: 40,
                color: AppColor.mainColor,
                wieght: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            );
          } else {
            return Container(
                child: Column(children: [
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Sales invoice",
                    size: 35,
                    wieght: FontWeight.w500,
                    color: AppColor.mainColor,
                    fontFamily: 'Pacifico',
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 6.5.h,
                        child: Form(
                          key: controllerInvoice.formState1,
                          child: CustomTextForm(
                            hint: 'Customer Name',
                            mycontroller: controllerInvoice.nameCustomer,
                            validator: (val) {
                              return validInput(val!, 2, 50, 'username');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.clearAll();
                    },
                    icon: Icon(Icons.delete_forever_outlined),
                    iconSize: 35,
                    color: AppColor.red,
                    tooltip: 'to delete all invoice',
                  )
                ],
              ),
              Expanded(
                child: Container(
                    height: 85.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                        padding: EdgeInsets.only(top: 5.h),
                        scrollDirection: Axis.vertical,
                        clipBehavior: Clip.hardEdge,
                        // squeeze: 1.01,
                        itemExtent: 200,
                        //  diameterRatio: 100.sp,
                        children: controller.productsMap.isNotEmpty
                            ? List.generate(controller.productsMap.length,
                                (index) {
                                if (index < controller.productsMap.length) {
                                  return CardSaleProduct(
                                    index: index,
                                    productSale: controller.productsMap.keys
                                        .toList()[index],
                                    counter: controller.productsMap.values
                                        .toList()[index],
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              })
                            : <Widget>[])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: 'Total',
                          size: 20,
                          wieght: FontWeight.w500,
                          color: AppColor.mainColor),
                      CustomText(
                          text: '${controller.prouctTotlalPrice.toString()}\$',
                          size: 20,
                          wieght: FontWeight.normal,
                          color: AppColor.grey),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      int tapCount = prefs.getInt('tapCount') ?? 0;

                      List<String>? valuesList = controller.productsMap.values
                          .map((e) => e.toString())
                          .toList();
                      String firstValue = valuesList[0];
                      String secondValue = valuesList[1];
                      if (tapCount == 0) {
                        String? productId = prefs.getString('key1');
                        await prefs.setString('key1', firstValue);
                      } else if (tapCount == 1) {
                        String? productId1 = prefs.getString('key2');
                        await prefs.setString('key2', secondValue);
                      }
                      String? productId = prefs.getString('key1');
                      String? productId1 = prefs.getString('key2');
                      controllerInvoice.addinvoice(
                        controllerInvoice.nameCustomer.text,
                        firstValue,
                        productId!,
                        secondValue,
                        productId1!,
                      );
                      controller.clearAll();
                      await prefs.setInt('tapCount', tapCount + 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                          height: 7.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: AppColor.mainColor),
                          child: Center(
                            child: CustomText(
                              text: 'Check Out',
                              wieght: FontWeight.w600,
                              color: AppColor.white,
                              size: 35,
                            ),
                          )),
                    ),
                  ),
                ],
              )
            ]));
          }
        }),
      ),
    );
  }
}
