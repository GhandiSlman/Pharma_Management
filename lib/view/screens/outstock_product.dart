import 'package:flutter/material.dart';
import 'package:pharma_man/view/widgets/card_out_stock_product.dart';

import '../../core/const/appcolor.dart';
import '../widgets/custom_text.dart';
class OutStockProducts extends StatelessWidget {
   OutStockProducts({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
body: SingleChildScrollView(
  child:   Column(
  
    children: [
       CustomText(
              text: 'Products Out of Stock',
              size: 25,
              wieght: FontWeight.normal,
              color: AppColor.mainColor,
              fontFamily: 'Pacifico',
            ),
       CardOutStockProduct(),
  
    ],
  
  ),
)


    ));
  }
}
