import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/componenets/my_title.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/auth_providers/signup_provider.dart';
import 'package:helply_app/screens/auth/login_screen.dart';
import 'package:helply_app/screens/auth/signup_screens/screen_one.dart';
import 'package:helply_app/screens/auth/signup_screens/screen_three.dart';
import 'package:helply_app/screens/auth/signup_screens/screen_two.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SignUpProvider signUpProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    PageController pageController = PageController(initialPage: 1);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/home_image.jpg",
                height: h * 0.4, fit: BoxFit.fitHeight),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: h * 0.4,
              width: MediaQuery.of(context).size.width,
              color: Colors.teal.withOpacity(0.6),
              child: const Text(""),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/helply.png",
              width: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(20),
                height: h * 0.7,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  children: [
                    const MyTitle(title: "SIGN UP"),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Empower change through service\nSign in to make a difference",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: signUpProvider.pageController,
                        children: const [
                          ScreenOne(),
                          ScreenTwo(),
                          ScreenThree()
                        ],
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: secondaryColor),
                        onPressed: () {
                          MyNavigator.pushReplacementNavigator(
                              context, LoginScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Aldredy have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(color:Colors.black),
                            ),
                            Text(
                              "  Login here",
                              style: TextStyle(color: primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
