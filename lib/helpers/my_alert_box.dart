
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/helpers/my_navigator.dart';

class MyAlertBox {
  static myShowDialog(BuildContext context, String title, VoidCallback onclick) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 30, horizontal: 30),
          content: Text(
            title, style: const TextStyle(), textAlign: TextAlign.center,),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      child: MyButton(width: 0.3,
                          onclick: onclick,
                          title: "Okay",)
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}