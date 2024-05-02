import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterflow_paginate_firestore/bloc/pagination_listeners.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/event_providers/upload_event_provider.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/events/single_event_screen.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UpcomingEventsScreen extends StatefulWidget {
  const UpcomingEventsScreen({super.key});

  @override
  State<UpcomingEventsScreen> createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  ///this is for convert date
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  ///this is for page refresh
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  ///This is for page view controls
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    UpcomingEventProvider upcomingEvent = Provider.of(context);
    UserDetailProvider userDetailProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Upcoming Events"),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: whiteColor,
          ),
          child: Center(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: w * 0.9,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const LineIcon.filter(),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            upcomingEvent.currentPosition = 0;
                            pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves
                                  .easeInOut, // Adjust the curve as needed
                            );
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              color: upcomingEvent.currentPosition == 0
                                  ? secondaryColor
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: upcomingEvent.currentPosition == 0
                                      ? Colors.teal.shade700
                                      : Colors.grey.shade500),
                              boxShadow: upcomingEvent.currentPosition == 0
                                  ? [
                                      const BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                          spreadRadius: 1)
                                    ]
                                  : [],
                            ),
                            child: Text(
                              "All Events",
                              style: TextStyle(
                                  color: upcomingEvent.currentPosition == 0
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              upcomingEvent.currentPosition = 1;
                              pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves
                                    .easeInOut, // Adjust the curve as needed
                              );
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                                color: upcomingEvent.currentPosition == 1
                                    ? secondaryColor
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: upcomingEvent.currentPosition == 1
                                    ? [
                                        const BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1, 2),
                                            blurRadius: 3,
                                            spreadRadius: 1)
                                      ]
                                    : [],
                                border: Border.all(
                                    color: upcomingEvent.currentPosition == 1
                                        ? Colors.teal.shade700
                                        : Colors.grey.shade500)),
                            child: Text(
                              "Skills Matched",
                              style: TextStyle(
                                  color: upcomingEvent.currentPosition == 1
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            upcomingEvent.currentPosition = 2;
                            pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves
                                  .easeInOut, // Adjust the curve as needed
                            );
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              color: upcomingEvent.currentPosition == 2
                                  ? secondaryColor
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: upcomingEvent.currentPosition == 2
                                      ? Colors.teal.shade700
                                      : Colors.grey.shade500),
                              boxShadow: upcomingEvent.currentPosition == 2
                                  ? [
                                      const BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(1, 2),
                                          blurRadius: 3,
                                          spreadRadius: 1)
                                    ]
                                  : [],
                            ),
                            child: Text(
                              "My City",
                              style: TextStyle(
                                  color: upcomingEvent.currentPosition == 2
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ///page one
                          RefreshIndicator(
                            child: PaginateFirestore(
                              //item builder type is compulsory.
                              itemBuilder: (context, documentSnapshots, index) {
                                final events =
                                    documentSnapshots[index].data() as Map?;
                                String eventUser = events!['eventUserName'];
                                String eventUserImg =
                                    events['eventUserPicture'];
                                String eventId = events['eventId'];
                                String eventName = events['eventName'];
                                String eventDate = convertDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        events['eventDate']));
                                String eventDescription =
                                    events['eventDescription'];
                                String eventTitle = events["eventName"];
                                String eventCountry = events["eventNation"];
                                String eventState = events['eventState'];
                                String eventCity = events['eventCity'];
                                String eventLandmark = events['eventLandmark'];
                                List<dynamic> skills =
                                    events["eventRequiredSkills"];
                                String eventOwnerId = events['eventOwnerId'];
                                String eventRequirement =
                                    events["eventRequirements"];
                                EventModel eventModel = EventModel(
                                    eventId: eventId,
                                    eventName: eventName,
                                    eventUser: eventUser,
                                    eventUserImg: eventUserImg,
                                    eventDate: eventDate,
                                    eventDescription: eventDescription,
                                    eventTitle: eventTitle,
                                    eventCountry: eventCountry,
                                    eventState: eventState,
                                    eventCity: eventCity,
                                    skills: skills,
                                    eventRequirement: eventRequirement,
                                    eventLandMark: eventLandmark,
                                    eventOwnerId: eventOwnerId);
                                return GestureDetector(
                                  onTap: () {
                                    MyNavigator.pushNavigator(
                                        context,
                                        SingleEventScreen(
                                          eventModel: eventModel,
                                          intrestButton:
                                              upcomingEvent.aldredyVisited,
                                        ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: ClipOval(
                                                      child: Image.network(
                                                    eventModel.eventUserImg,
                                                    fit: BoxFit.cover,
                                                  )),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(eventModel.eventUser),
                                                    const Text(
                                                      "12 Events Achived",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  eventModel.eventDate,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                        Text(eventModel.eventName)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              // orderBy is compulsory to enable pagination
                              query: FirebaseFirestore.instance
                                  .collection('events').where("isEventCompleted",isEqualTo: false),
                              //Change types accordingly
                              itemBuilderType: PaginateBuilderType.listView,
                              initialLoader: SpinKitRipple(
                                color: primaryColor,
                                size: 50.0,
                              ),
                              bottomLoader:SpinKitRipple(
                                color: primaryColor,
                                size: 50.0,
                              ),
                              onEmpty: Lottie.asset("assets/lottie/no_data_found.json", width: 300 ,repeat:false),
                              // to fetch real-time data
                              listeners: [
                                refreshChangeListener,
                              ],
                              isLive: false,
                            ),
                            onRefresh: () async {
                              refreshChangeListener.refreshed = true;
                            },
                          ),

                          ///Page two
                          RefreshIndicator(
                            child: PaginateFirestore(
                              //item builder type is compulsory.
                              itemBuilder: (context, documentSnapshots, index) {
                                final events =
                                    documentSnapshots[index].data() as Map?;
                                String eventUser = events!['eventUserName'];
                                String eventUserImg =
                                    events['eventUserPicture'];
                                String eventId = events['eventId'];
                                String eventName = events['eventName'];
                                String eventDate = convertDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        events['eventDate']));
                                String eventDescription =
                                    events['eventDescription'];
                                String eventTitle = events["eventName"];
                                String eventCountry = events["eventNation"];
                                String eventState = events['eventState'];
                                String eventCity = events['eventCity'];
                                String eventLandmark = events['eventLandmark'];
                                List<dynamic> skills =
                                    events["eventRequiredSkills"];
                                String eventOwnerId = events['eventOwnerId'];
                                String eventRequirement =
                                    events["eventRequirements"];
                                checkUser() async {
                                  QuerySnapshot data = await FirebaseFirestore
                                      .instance
                                      .collection("requestedWorks")
                                      .where("eventId", isEqualTo: eventId)
                                      .where("userId",
                                          isEqualTo: userDetailProvider.userId)
                                      .get();
                                }

                                checkUser();
                                EventModel eventModel = EventModel(
                                    eventId: eventId,
                                    eventName: eventName,
                                    eventUser: eventUser,
                                    eventUserImg: eventUserImg,
                                    eventDate: eventDate,
                                    eventDescription: eventDescription,
                                    eventTitle: eventTitle,
                                    eventCountry: eventCountry,
                                    eventState: eventState,
                                    eventCity: eventCity,
                                    skills: skills,
                                    eventRequirement: eventRequirement,
                                    eventLandMark: eventLandmark,
                                    eventOwnerId: eventOwnerId);
                                return GestureDetector(
                                  onTap: () {
                                    MyNavigator.pushNavigator(
                                        context,
                                        SingleEventScreen(
                                            eventModel: eventModel));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: ClipOval(
                                                      child: Image.network(
                                                    eventModel.eventUserImg,
                                                    fit: BoxFit.cover,
                                                  )),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(eventModel.eventUser),
                                                    const Text(
                                                      "12 Events Achived",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  eventModel.eventDate,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                        Text(eventModel.eventName)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              // orderBy is compulsory to enable pagination
                              query: FirebaseFirestore.instance
                                  .collection('events')
                                  .where("eventRequiredSkills",
                                      arrayContainsAny:
                                          userDetailProvider.skills),
                              //Change types accordingly
                              itemBuilderType: PaginateBuilderType.listView,
                              onLoaded: (s) {},
                              onPageChanged: (p0) => setState(() {}),
                              // to fetch real-time data
                              listeners: [
                                refreshChangeListener,
                              ],
                              isLive: true,
                            ),
                            onRefresh: () async {
                              refreshChangeListener.refreshed = true;
                            },
                          ),

                          ///Page three
                          RefreshIndicator(
                            child: PaginateFirestore(
                              //item builder type is compulsory.
                              itemBuilder: (context, documentSnapshots, index) {
                                final events =
                                    documentSnapshots[index].data() as Map?;
                                String eventUser = events!['eventUserName'];
                                String eventUserImg =
                                    events['eventUserPicture'];
                                String eventId = events['eventId'];
                                String eventName = events['eventName'];
                                String eventDate = convertDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        events['eventDate']));
                                String eventDescription =
                                    events['eventDescription'];
                                String eventTitle = events["eventName"];
                                String eventCountry = events["eventNation"];
                                String eventState = events['eventState'];
                                String eventCity = events['eventCity'];
                                String eventLandmark = events['eventLandmark'];
                                List<dynamic> skills =
                                    events["eventRequiredSkills"];
                                String eventOwnerId = events['eventOwnerId'];
                                String eventRequirement =
                                    events["eventRequirements"];
                                checkUser() async {
                                  QuerySnapshot data = await FirebaseFirestore
                                      .instance
                                      .collection("requestedWorks")
                                      .where("eventId", isEqualTo: eventId)
                                      .where("userId",
                                          isEqualTo: userDetailProvider.userId)
                                      .get();
                                }

                                checkUser();
                                EventModel eventModel = EventModel(
                                    eventId: eventId,
                                    eventName: eventName,
                                    eventUser: eventUser,
                                    eventUserImg: eventUserImg,
                                    eventDate: eventDate,
                                    eventDescription: eventDescription,
                                    eventTitle: eventTitle,
                                    eventCountry: eventCountry,
                                    eventState: eventState,
                                    eventCity: eventCity,
                                    skills: skills,
                                    eventRequirement: eventRequirement,
                                    eventLandMark: eventLandmark,
                                    eventOwnerId: eventOwnerId);
                                return GestureDetector(
                                  onTap: () {
                                    MyNavigator.pushNavigator(
                                        context,
                                        SingleEventScreen(
                                            eventModel: eventModel));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: ClipOval(
                                                      child: Image.network(
                                                    eventModel.eventUserImg,
                                                    fit: BoxFit.cover,
                                                  )),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(eventModel.eventUser),
                                                    const Text(
                                                      "12 Events Achived",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  eventModel.eventDate,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                        Text(eventModel.eventName)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              // orderBy is compulsory to enable pagination
                              query: FirebaseFirestore.instance
                                  .collection('events')
                                  .where("eventCity",
                                      isEqualTo: userDetailProvider.userCity),
                              //Change types accordingly
                              itemBuilderType: PaginateBuilderType.listView,
                              onLoaded: (s) {},
                              onPageChanged: (p0) => setState(() {}),
                              // to fetch real-time data
                              listeners: [
                                refreshChangeListener,
                              ],
                              isLive: true,
                            ),
                            onRefresh: () async {
                              refreshChangeListener.refreshed = true;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
