import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/constants/colors.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Chat"),
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
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
