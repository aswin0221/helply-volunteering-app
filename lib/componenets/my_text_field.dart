import 'package:flutter/material.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/responsive.dart';

class MyTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  const MyTextField({super.key,required this.controller , required this.hintText , this.icon});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width*1;
    return ResponsiveWidget(mobile: TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder:OutlineInputBorder(
            borderSide:  BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black45),
          contentPadding: const EdgeInsets.all(13),
      ),
    ), desktop: TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          constraints: BoxConstraints(
            maxWidth: w*0.3
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black45),
          contentPadding: const EdgeInsets.all(13)),
    ));
  }
}
