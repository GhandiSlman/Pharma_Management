import 'package:get/get.dart';
import 'package:pharma_man/view/screens/add_discount.dart';
import 'package:pharma_man/view/screens/add_donation.dart';
import 'package:pharma_man/view/screens/add_employee.dart';
import 'package:pharma_man/view/screens/all_donation.dart';
import 'package:pharma_man/view/screens/all_employee.dart';
import 'package:pharma_man/view/screens/all_suppliers.dart';
import 'package:pharma_man/view/screens/auth/check_code.dart';
import 'package:pharma_man/view/screens/auth/forget_password.dart';
import 'package:pharma_man/view/screens/auth/login.dart';
import 'package:pharma_man/view/screens/auth/signup.dart';
import 'package:pharma_man/view/screens/edit_purchase.dart';
import 'package:pharma_man/view/screens/edit_supplier.dart';
import 'package:pharma_man/view/screens/expired_product.dart';
import 'package:pharma_man/view/screens/get_invoice.dart';
import 'package:pharma_man/view/screens/main_sceeen_as_user.dart';
import 'package:pharma_man/view/screens/main_screen_as_admin.dart';
import 'package:pharma_man/view/screens/outstock_product.dart';

import 'package:pharma_man/view/screens/post_supplier.dart';

import 'package:pharma_man/view/screens/add_purchase.dart';
import 'package:pharma_man/view/screens/main_sale.dart';
import 'package:pharma_man/view/screens/sales.dart';
import 'package:pharma_man/view/screens/update_donation.dart';




List<GetPage<dynamic>>? routes = [
    GetPage(name: '/', page:() => Login(),),
    GetPage(name: '/signup', page:() => SignUp()),
   // GetPage(name: '/home', page:() => HomePage()),
    GetPage(name: '/forgetpass', page:() => ForgetPass()),
    GetPage(name: '/checkcode', page:() => CheckCode()),
    GetPage(name: '/mainscreenasadmin', page: () => MainScreenAsAdmin()),
    GetPage(name: '/mainscreenasuser', page: () => MainScreenAsUser()),
   
    GetPage(name: '/slaesscreen', page: ()=> SalesScreen()),
    GetPage(name: '/postsuppliers', page: ()=> PostSuppliersScreen() ),
    GetPage(name: '/addpurchase', page:() => AddPurchase()),
    //GetPage(name: '/mainsale', page:() => MainSale()),
    //GetPage(name: '/adddebt', page:() => AddDebt()),
    GetPage(name: '/allsuppliers', page:() => AllSuppliers()),
    GetPage(name: '/editsupplier', page:() => EditSupplier()),
    GetPage(name: '/getInvoice', page:() => GetInvoiceScreen()),
    GetPage(name: '/allemployees', page:() => AllEmployees()),
    GetPage(name: '/addEmploye', page:() => AddEmploye()),
    GetPage(name: '/editPurchase', page:() => EditPurchase()),
    GetPage(name: '/expiredProduct', page:() => ExpiredProducts()), 
    GetPage(name: '/outstockProduct', page:() => OutStockProducts()),
    GetPage(name: '/alldonation', page:() => AllDonations()),
     GetPage(name: '/adddonation', page:() => AddDonation()),
     GetPage(name: '/updatedonation', page:() => UpdateDonation()),
     GetPage(name: '/addDiscount', page:() => AddDiscount()),
      
];
