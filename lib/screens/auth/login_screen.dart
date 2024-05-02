import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/componenets/my_title.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/auth_providers/login_provider.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/responsive.dart';
import 'package:helply_app/screens/Home/home_screen.dart';
import 'package:helply_app/screens/auth/forgot_password_screen.dart';
import 'package:helply_app/screens/auth/signup_screens/signup_screen.dart';
import 'package:helply_app/screens/auth/verify_email_Screen.dart';
import 'package:helply_app/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of(context);
    double w= MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ResponsiveWidget(
        mobile: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/home_image.jpg",
                  height: h*0.4, fit: BoxFit.fitHeight),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: h*0.4,
                width: MediaQuery.of(context).size.width,
                color: Colors.teal.withOpacity(0.6),
                child: const Text(""),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/helply.png",width: 300,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: h*0.7,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Column(
                    children: [
                      const MyTitle(title: "SIGN IN"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Welcome Back You're \n been missed !!!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyTextField(controller: loginProvider.email, hintText: "Email"),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(controller: loginProvider.password, hintText: "Password"),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                MyNavigator.pushNavigator(context, ForgotPasswordScreen());
                              },
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(color: Colors.teal),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.teal,
                            Colors.teal,
                            Colors.teal,
                            Colors.teal,
                            Colors.teal,
                            Colors.teal.shade700,
                          ]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: const Size(300, 50)),
                            onPressed: () {
                              if(loginProvider.validate(context))
                                {
                                  loginProvider.login(context);
                                }
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Divider(),
                      ),
                      SignInButton(Buttons.google, onPressed: () {}),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: secondaryColor
                          ),
                          onPressed: () {
                            MyNavigator.pushReplacementNavigator(context, const SignUpScreen());
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an Account?",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Create Account",
                                style: TextStyle(color: Colors.teal),
                              )
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ),
        desktop: Row(
          children: [
            Container(
              height: h,
                child: Image.asset("assets/auth.jpg",fit: BoxFit.fitHeight,)),
            Container(
              width: w*0.3,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: h*0.4,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.teal.withOpacity(0.6),
                      child: const Text(""),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/helply.png",width: 280,),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        height: h*0.7,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        child: Column(
                          children: [
                            const MyTitle(title: "SIGN IN"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Welcome Back You're \n been missed !!!",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            MyTextField(controller: TextEditingController(), hintText: "Email"),
                            const SizedBox(
                              height: 5,
                            ),
                            MyTextField(controller: TextEditingController(), hintText: "Password"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forgot Password ?",
                                      style: TextStyle(color: Colors.teal),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.teal,
                                  Colors.teal,
                                  Colors.teal,
                                  Colors.teal,
                                  Colors.teal,
                                  Colors.teal.shade700,
                                ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      fixedSize: const Size(300, 50)),
                                  onPressed: () {
                                    MyNavigator.pushReplacementNavigator(context, VerifyEmailScreen());
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Divider(),
                            ),
                            SignInButton(Buttons.google, onPressed: () {}),
                            const SizedBox(
                              height: 5,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: secondaryColor
                                ),
                                onPressed: () {
                                 //MyNavigator.pushReplacementNavigator(context, const MainScreen());
                                },
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an Account?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Create Account",
                                      style: TextStyle(color: Colors.teal),
                                    )
                                  ],
                                ))
                          ],
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
