import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final double width;
  final VoidCallback onclick;
  final bool isLoading;
  const MyButton({super.key , required this.title , required this.width , required this.onclick, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    double w =  MediaQuery.of(context).size.width;
    double h =  MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: !isLoading ? LinearGradient(colors: [
          Colors.teal,
          Colors.teal,
          Colors.teal,
          Colors.teal,
          Colors.teal,
          Colors.teal.shade700,
        ]) :  LinearGradient(colors: [Colors.grey.shade200,Colors.grey.shade200]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              fixedSize:  Size(w*width, 50)),
          onPressed: isLoading ? null : onclick,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}
