import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

void showPopupMenu(BuildContext context) {
  showMenu(
      context: context,
      position: RelativeRect.fromDirectional(
        textDirection: TextDirection.ltr,
        start: 10.h,
        top: 1.h,
        end: 1.h,
        bottom: 1.h,
      ),
      items: [
        PopupMenuItem(
          child: Text('Supplier 1'),
        ),
        PopupMenuItem(
          child: Text('Supplier 2'),
        ),
        PopupMenuItem(
          child: Text('Supplier 3'),
        ),
        PopupMenuItem(
          child: Text('Supplier 4'),
        ),
      ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      )).then((value) => null);
}
void showPopupMenu2(BuildContext context) {
  showMenu(
      context: context,
      position: RelativeRect.fromDirectional(
        textDirection: TextDirection.ltr,
        start: 10.h,
        top: 1.h,
        end: 1.h,
        bottom: 1.h,
      ),
      items: [
        PopupMenuItem(
          child: Text('Drink'),
        ),
        PopupMenuItem(
          child: Text('Capsules'),
        ),
      ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      )).then((value) => null);
}

