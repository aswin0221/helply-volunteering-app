import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade300.withOpacity(0.3),
      body: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.6,
              child: Lottie.asset("assets/lottie/hands.json",width: 200),
            ),
            Text("")
          ],
        ),
      ),
    );
  }
}
