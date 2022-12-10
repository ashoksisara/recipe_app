import 'package:flutter/material.dart';

class AppAlertDialog {
  static void showAlertDialog(BuildContext context,
      {required String alertMessage,
      required String button1Text,
      required String button2Text,
      required Function onTapButton1,
      required Function onTapButton2}) {

    Widget button1 = TextButton(
      child: Text(button1Text),
      onPressed: () {
        onTapButton1.call();
      },
    );
    Widget button2 = TextButton(
      child: Text(button2Text),
      onPressed: () {
        onTapButton2.call();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Alert!"),
      content: Text(alertMessage),
      actions: [
        button1,
        button2,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
