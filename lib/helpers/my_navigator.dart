import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyNavigator {

  static void pushReplacementNavigator(BuildContext context , Widget child)
  {
    Navigator.pushReplacement(context, PageTransition(child: child, type: PageTransitionType.fade));
  }

  static void pushReplacementNavigatorBack(BuildContext context , Widget child)
  {
    Navigator.pushReplacement(context, PageTransition(child: child, type: PageTransitionType.leftToRight));
  }

  static void pushNavigator(BuildContext context , Widget child)
  {
    Navigator.push(context, PageTransition(child: child, type: PageTransitionType.fade));
  }

  static  pop(BuildContext context)
  {
    Navigator.pop(context);
  }


}