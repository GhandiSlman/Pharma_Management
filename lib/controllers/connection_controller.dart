import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  var _hasInternetConnection = false.obs;

  bool get hasInternetConnection => _hasInternetConnection.value;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    _hasInternetConnection.value = isConnected;
  }
}
