import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_alert_box.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:helply_app/screens/volunteer/single_volunteer_screen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RequestedPersonsScreen extends StatefulWidget {
  final String eventId;

  const RequestedPersonsScreen({super.key, required this.eventId});

  @override
  State<RequestedPersonsScreen> createState() => _RequestedPersonsScreenState();
}

class _RequestedPersonsScreenState extends State<RequestedPersonsScreen> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    MyEventUploadProvider myEventUploadProvider =
        Provider.of(context, listen: false);
    myEventUploadProvider.getRequestsPeople(widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyEventUploadProvider eventUploadProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar(""),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: whiteColor,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Requestes",
                    style: TextStyle(
                        color: currentPage == 0 ? primaryColor : Colors.grey,
                        fontWeight: currentPage == 0
                            ? FontWeight.bold
                            : FontWeight.w400),
                  ),
                  Text(
                    "Accepted Peoples",
                    style: TextStyle(
                        color: currentPage == 1 ? primaryColor : Colors.grey,
                        fontWeight: currentPage == 1
                            ? FontWeight.bold
                            : FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (index) {
                    currentPage = index;
                    setState(() {});
                  },
                  children: [
                    eventUploadProvider.requestPeoples.isEmpty
                        ? const MyLoader()
                        : ListView.builder(
                            itemCount:
                                eventUploadProvider.requestPeoples.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: MaterialButton(
                                        onPressed: () {
                                          MyNavigator.pushNavigator(
                                              context,
                                              SingleVolunteerScreen(
                                                  usersModel:
                                                      eventUploadProvider
                                                              .requestPeoples[
                                                          index]));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(eventUploadProvider
                                                .requestPeoples[index]
                                                .userName),
                                            Row(
                                              children: [
                                                Text(
                                                  "Check Profile",
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: primaryColor,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "requestedWorks")
                                                    .doc(eventUploadProvider
                                                        .requestPeoples[index]
                                                        .requestDocId)
                                                    .update({"status": true}).then((value) {
                                                      eventUploadProvider.getRequestsPeople(widget.eventId);
                                                      setState(() {
                                                        MyAlertBox.myShowDialog(context, "Successfully Added to the team", () {
                                                          MyNavigator.pop(context);
                                                        });
                                                      });
                                                });
                                              },
                                              icon: Icon(
                                                Icons
                                                    .check_circle_outline_sharp,
                                                size: 34,
                                                color: primaryColor,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "requestedWorks")
                                                    .doc(eventUploadProvider
                                                        .requestPeoples[index]
                                                        .requestDocId)
                                                    .delete();
                                              },
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                                size: 34,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                    eventUploadProvider.acceptedPeoples.isEmpty
                        ? const MyLoader()
                        : ListView.builder(
                            itemCount:
                                eventUploadProvider.acceptedPeoples.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: MaterialButton(
                                        onPressed: () {
                                          MyNavigator.pushNavigator(
                                              context,
                                              SingleVolunteerScreen(
                                                  usersModel:
                                                      eventUploadProvider
                                                              .acceptedPeoples[
                                                          index]));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(eventUploadProvider
                                                .acceptedPeoples[index]
                                                .userName),
                                            Row(
                                              children: [
                                                Text(
                                                  "Check Profile",
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: primaryColor,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {},
                                      child: Text(eventUploadProvider
                                          .acceptedPeoples[index].mobileNumber),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.email))
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
