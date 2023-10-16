import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/donation_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_app_bar.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_text_form.dart';
import 'package:pharma_man/view/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class UpdateDonation extends StatelessWidget {
  DonationController controller = Get.put(DonationController());
  final String id = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'Update Donation'),
      backgroundColor: AppColor.white,
      body: Container(
        padding: EdgeInsets.all(3.h),
        child: ListView(children: [
           Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomTextForm(
                hint: 'Name',
                icon: Icons.medication_sharp,
                mycontroller: controller.name,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextForm(
                type: TextInputType.number,
                hint: 'Quantity',
                icon: Icons.production_quantity_limits,
                mycontroller: controller.quantity,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextForm(
                type: TextInputType.datetime,
                hint: 'Expiry date',
                icon: Icons.date_range_outlined,
                mycontroller: controller.date,
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomButtom(
                text: 'Update',
                onPressed: () {
                  if (controller.name.text.isEmpty &&
                      controller.barcode.text.isEmpty &&
                      controller.quantity.text.isEmpty &&
                      controller.date.text.isEmpty) {
                    showNotificationSnackbar('Oops!', 'Did not editing anything');
                  }else{
                     controller.updateDonation(
                    controller.name.text,
                    controller.barcode.text,
                    controller.quantity.text,
                    controller.date.text,
                    id,
                  );
                  }
                 
                },
                gradient: LinearGradient(
                    colors: [AppColor.color1, AppColor.color2],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                textColor: AppColor.white,
                width: double.infinity,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
