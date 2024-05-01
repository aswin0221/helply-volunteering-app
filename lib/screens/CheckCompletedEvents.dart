import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/give_review_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/my_navigator.dart';

class CheckCompletedEvents extends StatefulWidget {
  const CheckCompletedEvents({super.key});

  @override
  State<CheckCompletedEvents> createState() => _CheckCompletedEventsState();
}

class _CheckCompletedEventsState extends State<CheckCompletedEvents> {
  @override
  Widget build(BuildContext context) {
    UserDetailProvider userDetailProvider = Provider.of(context);
    MyEventUploadProvider myEventUploadProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Completed Events"),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: whiteColor),
          child: SafeArea(
            child: Center(
              child: Container(
                width: w * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello ${userDetailProvider.userName} ,",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const Text(
                      "Confirm weather the below events are completed!",
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            myEventUploadProvider.checkCompleteStatus.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: ClipOval(
                                              child: Image.network(
                                            myEventUploadProvider
                                                .checkCompleteStatus[index]
                                                .eventUserImg,
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(myEventUploadProvider
                                                .checkCompleteStatus[index]
                                                .eventUser),
                                            const Text(
                                              "12 Events Achived",
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          myEventUploadProvider
                                              .checkCompleteStatus[index]
                                              .eventDate,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                        Icon(
                                          Icons.bookmark,
                                          color: primaryColor,
                                          size: 18,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  myEventUploadProvider
                                      .checkCompleteStatus[index].eventTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(myEventUploadProvider
                                    .checkCompleteStatus[index]
                                    .eventDescription),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        ///mark as completed
                                        FirebaseFirestore.instance
                                            .collection("events")
                                            .doc(myEventUploadProvider
                                                .checkCompleteStatus[index]
                                                .eventId)
                                            .update({
                                          "isEventCompleted": true
                                        }).then((value) {
                                          ///set the programe owner in completed events
                                          FirebaseFirestore.instance
                                              .collection("completedEvents")
                                              .doc()
                                              .set({
                                            "userId": FirebaseAuth
                                                .instance.currentUser!.uid,
                                            "eventId": myEventUploadProvider
                                                .checkCompleteStatus[index]
                                                .eventId
                                          }).then((value) {
                                            MyNavigator.pushReplacementNavigator(
                                                context,
                                                GiveReviewScreen(
                                                    eventId:
                                                        myEventUploadProvider
                                                            .checkCompleteStatus[
                                                                index]
                                                            .eventId));
                                          });
                                        });
                                      },
                                      color: primaryColor,
                                      child: const Text(
                                        "Completed",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {});
                                        FirebaseFirestore.instance
                                            .collection("events")
                                            .doc(myEventUploadProvider
                                                .checkCompleteStatus[index]
                                                .eventId)
                                            .set({"isEventCanceled": true});
                                        myEventUploadProvider.myUploads = [];
                                        myEventUploadProvider.getMyUploads();
                                      },
                                      color: Colors.redAccent,
                                      child: const Text(
                                        "Canceled",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
