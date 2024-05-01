import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/constants/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController resetPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Change password"),
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
                          Column(
                            children: [
                              MyTextField(controller: TextEditingController(), hintText: "Email"),
                              SizedBox(height: 20,),
                              MyButton(title: "Reset password", width: 0.5, onclick: (){
                                FirebaseAuth.instance.sendPasswordResetEmail(email:resetPassword.text.trim());
                              }),
                              SizedBox(height: 20,),
                              const Text("email will send to the registerd Email",textAlign: TextAlign.center,),
                            ],
                          ),
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
