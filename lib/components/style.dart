//success toast message
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSuccessToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey[800],
    textColor: Colors.green,
    fontSize: 16.0,
  );
}


void showErrorToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey[800],
    textColor: Colors.red,
    fontSize: 16.0,
  );
}