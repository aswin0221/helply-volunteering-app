import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_local_database.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/screens/main_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  Timer? myTimer;

  ///Verifiy Email
  static bool checkVerification() {
    FirebaseAuth.instance.currentUser?.reload();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
       ///Send verification
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    checkingVerificationTimer();
  }

  checkingVerificationTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      bool verify = checkVerification();
      if (verify) {
        timer.cancel();
        if (context.mounted) {
          MyLocalStorage.setBool("isLogin", true);
          MyNavigator.pushReplacementNavigator(context, const MainScreen());
        }
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Verify Email"),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: whiteColor),
          child: SafeArea(
            child: Center(
              child: Container(
                width: w*0.9,
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Center(
                              child: FittedBox(
                                  child: Column(
                                    children: [
                                      const Text("Verification Mail is Sent to"),
                                      Text("aswincuts123@gmail.com",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      SizedBox(height: 50,),
                                      MyButton(title: "Resend Email", width: 0.5, onclick: (){})
                                    ],
                                  ))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
