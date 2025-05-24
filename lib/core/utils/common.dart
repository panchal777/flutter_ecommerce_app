import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'
    show Fluttertoast, ToastGravity, Toast;

class Common {
  static void toastMessage(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
