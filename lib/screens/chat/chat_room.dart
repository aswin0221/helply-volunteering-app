import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:helply_app/helpers/my_alert_box.dart';
import 'package:helply_app/providers/chat_provider.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  final String roomCode;

  const ChatRoom({super.key, required this.roomCode});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of(context);
    UserDetailProvider userDetailProvider = Provider.of(context);
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
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: w,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: PaginateFirestore(
                      //item builder type is compulsory.
                      itemBuilder: (context, documentSnapshots, index) {
                        final documentSnapshot = documentSnapshots[index];
                        Map<String, dynamic> data =
                            documentSnapshot.data() as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment:
                              data['userId'] == userDetailProvider.userId
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    data['userId'] == userDetailProvider.userId
                                        ? const EdgeInsets.only(right: 30)
                                        : const EdgeInsets.only(left: 30),
                                child:
                                    data['userId'] == userDetailProvider.userId
                                        ? Text(
                                            "You",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          )
                                        : Text(
                                            "${data['userName']}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          )),
                            GestureDetector(
                              onLongPress: () {
                                MyAlertBox.myShowDialog(context, "This is for report", () { });
                              },
                              child: BubbleSpecialThree(
                                text: data['message'],
                                color:
                                    data['userId'] == userDetailProvider.userId
                                        ? primaryColor
                                        : Colors.grey.shade400,
                                tail: true,
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                isSender:
                                    data['userId'] == userDetailProvider.userId
                                        ? true
                                        : false,
                              ),
                            ),
                          ],
                        );
                      },
                      // orderBy is compulsory to enable pagination
                      query: FirebaseFirestore.instance
                          .collection(widget.roomCode)
                          .orderBy("messageTime", descending: true),
                      //Change types accordingly
                      itemBuilderType: PaginateBuilderType.listView,
                      initialLoader: SpinKitRipple(
                        color: primaryColor,
                        size: 50.0,
                      ),
                      bottomLoader: SpinKitRipple(
                        color: primaryColor,
                        size: 50.0,
                      ),
                      onEmpty: Lottie.asset("assets/lottie/no_data_found.json",
                          width: 300, repeat: false),
                      reverse: true,
                      // to fetch real-time data
                      isLive: true,
                    ),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.shade100, boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 20, // Increased blur radius
                      offset: Offset(1, 1),
                    )
                  ]),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: MessageBar(
                    onSend: (message) {
                      chatProvider.sendChat(widget.roomCode, context, message);
                    },
                    sendButtonColor: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
