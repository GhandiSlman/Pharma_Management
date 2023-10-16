import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/barcode_controller.dart';
import 'package:pharma_man/controllers/categories_controller.dart';
import 'package:pharma_man/controllers/suppliers_controller.dart';
import 'package:pharma_man/controllers/update_purchase_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/card_categories.dart';
import 'package:pharma_man/view/widgets/custom_app_bar.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_icon_button.dart';
import 'package:pharma_man/view/widgets/custom_supplier.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_form.dart';
import 'package:sizer/sizer.dart';

class EditPurchase extends StatelessWidget {
  EditPurchase({Key? key}) : super(key: key);
  
  final String purchaseId = Get.arguments as String;
  final EditPurchaseController controller = Get.put(EditPurchaseController());
  final BacodeController controller1 = Get.put(BacodeController());
  final Catergores controller2 = Get.put(Catergores());
  final SuppliersCotroller controller3 = Get.put(SuppliersCotroller());

  // final ImageController controller4 = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: CustomAppBar(
            title: 'Edit invoice',
          ),
          body: Obx(
            () => controller.isLoading.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                        color: AppColor.color1,
                      )),
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomText(
                          text: 'Adding...',
                          size: 10.sp,
                          wieght: FontWeight.bold,
                          color: AppColor.grey),
                    ],
                  )
                : Form(
                    key: controller.formState,
                    child: Container(
                      // padding: EdgeInsets.all(3.h),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 9.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 0.9.w,
                              ),
                              CustomText(
                                text: 'add cat : ',
                                size: 20,
                                wieght: FontWeight.normal,
                                color: AppColor.grey,
                                fontFamily: 'Pacifico',
                              ),
                              CardCategories(),
                            ],
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 0.9.w,
                              ),
                              CustomText(
                                text: 'add sup : ',
                                size: 20,
                                wieght: FontWeight.normal,
                                color: AppColor.grey,
                                fontFamily: 'Pacifico',
                              ),
                              CustomSuppliers(),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(3.h),
                            child: Column(
                              children: [
                                // Divider(
                                //   color: Colors.grey,
                                //   height: 1,
                                //   thickness: 2,
                                //   indent: 20,
                                //   endIndent: 20,
                                // ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 70.w,
                                        child: CustomTextForm(
                                          mycontroller: controller1.barCode,
                                          hint: 'Barcode',
                                          icon: Icons.qr_code_2_outlined,
                                        )),
                                    // SizedBox(
                                    //   width: 2.w,
                                    // ),
                                    CustomIconButton(
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColor.grey,
                                      ),
                                      onPressed: () async {
                                        controller1.scanBarcode();
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width: 87.w,
                                  child: CustomTextForm(
                                    hint: 'Name of medicine',
                                    mycontroller: controller.name,
                                    icon: Icons.medication_outlined,
                                    validator: (val) {
                                      return validInput(val!, 0, 50, '');
                                    },
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 41.w,
                                        child: CustomTextForm(
                                          type: TextInputType.number,
                                          mycontroller: controller.netPrice,
                                          hint: 'Net price',
                                          icon: Icons.attach_money_rounded,
                                          validator: (val) {
                                            return validInput(val!, 1, 50, '');
                                          },
                                        )),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SizedBox(
                                        width: 41.w,
                                        child: CustomTextForm(
                                          type: TextInputType.number,
                                          hint: 'Sale price',
                                          mycontroller: controller.salePrice,
                                          icon: Icons.attach_money_rounded,
                                          validator: (val) {
                                            return validInput(val!, 1, 50, '');
                                          },
                                        )),
                                  ],
                                ),
                                SizedBox(height: 1.5.h),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 41.w,
                                        child: CustomTextForm(
                                          type: TextInputType.datetime,
                                          hint: 'Expiry date',
                                          mycontroller: controller.expiryDate,
                                          icon: Icons.history_toggle_off,
                                          validator: (val) {
                                            return validInput(val!, 1, 50, '');
                                          },
                                        )),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SizedBox(
                                      width: 41.w,
                                      child: CustomTextForm(
                                        type: TextInputType.number,
                                          hint: 'Quantity',
                                          mycontroller: controller.quantity,
                                          validator: (val) {
                                            return validInput(val!, 1, 50, '');
                                          },
                                          icon: Icons.add),
                                    ),
                                  ],
                                ),
                              
                                SizedBox(height: 6.h),
                                CustomButtom(
                                    text: 'edit Invoice',
                                    onPressed: () {
                                      controller.editpurchase(
                                        controller.name!.text ,
                                        controller.netPrice!.text,
                                        controller.salePrice!.text,
                                        controller2.id!.value.toString(),
                                        controller3.id!.value.toString(),
                                        controller.expiryDate!.text,
                                        controller.quantity!.text,
                                        controller1.barCode!.text,
                                        purchaseId
                                      );

                                    },
                                    gradient: LinearGradient(
                                        colors: [
                                          AppColor.color1,
                                          AppColor.color2
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                    textColor: AppColor.white,
                                    width: double.infinity),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
