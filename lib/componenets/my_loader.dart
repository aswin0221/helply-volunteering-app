import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:lottie/lottie.dart';

class MyLoader extends StatefulWidget {
  const MyLoader({Key? key}) : super(key: key);

  @override
  State<MyLoader> createState() => _MyLoaderState();
}

class _MyLoaderState extends State<MyLoader> {
  bool isTimeCompleted = false;

  @override
  void initState() {
    super.initState();
    // Start the timer
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Function to start the timer
  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          isTimeCompleted = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !isTimeCompleted
          ? SpinKitRipple(
        color: primaryColor,
        size: 50.0,
      )
          : Lottie.asset("assets/lottie/no_data_found.json", width: 300 ,repeat:false),
    );
  }
}
