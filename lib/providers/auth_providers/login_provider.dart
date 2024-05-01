import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/helpers/my_local_database.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/screens/auth/verify_email_Screen.dart';
import 'package:helply_app/screens/main_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginProvider extends ChangeNotifier {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login(BuildContext context)async{
    try
    {
      User? user = await firebaseAuth.signInWithEmailAndPassword(email:email.text.trim(), password: password.text.trim()).then((value){
      MyLocalStorage.setBool("isLogin", true);
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message:
            "Login successfully",
          ),
        );
        if(FirebaseAuth.instance.currentUser!.emailVerified)
          {
            print("helloo --------------verified");
            MyNavigator.pushNavigator(context, MainScreen());
          }
        else{
          MyNavigator.pushNavigator(context, VerifyEmailScreen());
        }
      });
    } on FirebaseAuthException catch(e){
      String errorMessage = "An unknown error occurred";
      if(e is FirebaseAuthException)
      {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = "Invalid email";
            break;
          case 'user-not-found':
            errorMessage = "User not found";
            break;
          case 'wrong-password':
            errorMessage = "Wrong password";
            break;
          case 'network-request-failed':
            errorMessage = "Network error";
            break;
          case 'user-disabled':
            errorMessage = "User disabled";
            break;
          case 'too-many-requests':
            errorMessage = "Too many requests. Try again later.";
            break;
        }
      }
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message:
          "Password resent link sent successfully",
        ),
      );
    }
  }

  bool validate(BuildContext context)
  {
    if(email.text.trim().isNotEmpty && password.text.trim().isNotEmpty)
      {
        return true;
      }
    else
      {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message:
            "All fields are manratory",
          ),
        );
        return false;
      }
  }

}