
import 'package:flutter/material.dart';
import 'package:pharma_man/view/widgets/card_employee.dart';
import 'package:sizer/sizer.dart';

import '../../core/const/appcolor.dart';
import '../widgets/custom_text.dart';


class AllEmployees extends StatelessWidget {
  const AllEmployees({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
            padding: EdgeInsets.all(4.h),
            child: Column(children: [
              
              CardEmployee(),
            ])),
   
    );
  }
}