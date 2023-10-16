import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/donation_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_app_bar.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_icon_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_form.dart';
import 'package:sizer/sizer.dart';

class AddDonation extends StatelessWidget {
  DonationController controller = Get.put(DonationController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Donation'),
      backgroundColor: AppColor.white,
      body: Container(
        padding: EdgeInsets.all(3.h),
        child: ListView(children: [
          Form(
              key: controller.formState,
              child: Column(
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  CustomTextForm(
                    hint: 'Name of Medicine',
                     validator: (val) {
                              return validInput(val!, 3, 50, '');
                            },
                    icon: Icons.medication_sharp,
                    mycontroller: controller.name,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                 Row(
                                
                                  children: [
                                    SizedBox(
                                        width: 68.w,
                                        child: CustomTextForm(
                                           validator: (val) {
                              return validInput(val!, 3, 50, '');
                            },
                                          mycontroller: controller.barcode,
                                          hint: 'Barcode',
                                          icon: Icons.qr_code_2_outlined,
                                        )),
                                    SizedBox(
                                      width: 1.0.w,
                                    ),
                                    CustomIconButton(
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColor.grey,
                                      ),
                                      onPressed: () async {
                                    
                                      },
                                    )
                                  ],
                                ),
                  SizedBox(
                    height: 3.h,
                  ),
                  CustomTextForm(
                     validator: (val) {
                              return validInput(val!, 3, 50, '');
                            },
                    type: TextInputType.number,
                    hint: 'Quantity',
                    icon: Icons.production_quantity_limits,
                    mycontroller: controller.quantity,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  CustomTextForm(
                     validator: (val) {
                              return validInput(val!, 3, 50, '');
                            },
                    type: TextInputType.datetime,
                    hint: 'Expiry date',
                    icon: Icons.date_range_outlined,
                    mycontroller: controller.date,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomButtom(
                    text: 'Add',
                    onPressed: () {
                      controller.addDonation(
                          controller.name.text,
                          controller.barcode.text,
                          controller.quantity.text,
                          controller.date.text);
                    },
                    gradient: LinearGradient(
                        colors: [AppColor.color1, AppColor.color2],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                    textColor: AppColor.white,
                    width: double.infinity,
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
