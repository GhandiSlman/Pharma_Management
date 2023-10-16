import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomerController extends GetxController{
//   var barcodeResult = ''.obs;

//   Future<void> scanBarcode() async {
//     String result = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.BARCODE);

//     if (!result.isEmpty) {
//       barcodeResult.value = result;
//     }
//   }
  
 }

class SearchDelegateX extends SearchDelegate<String> {
  

  final _searchResult = RxList<String>([]);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(_searchResult[index]));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(_searchResult[index]));
      },
    );
  }
}
