import 'package:flutter/material.dart';
import 'package:helply_app/constants/colors.dart';

AppBar myAppBar(String title){
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    backgroundColor: primaryColor,
    shape: const RoundedRectangleBorder(
       //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90),bottomRight: Radius.circular(90))
    ),
    title: Text(title,style: TextStyle(color: whiteColor),),
    centerTitle: true,
  );
}

