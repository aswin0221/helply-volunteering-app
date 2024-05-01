import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_alert_box.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/events/upcoming_events_screen.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SingleEventScreen extends StatefulWidget {
  final EventModel eventModel;
  final bool intrestButton;

  const SingleEventScreen(
      {super.key, required this.eventModel, this.intrestButton = true});

  @override
  State<SingleEventScreen> createState() => _SingleEventScreenState();
}

class _SingleEventScreenState extends State<SingleEventScreen> {
  @override
  Widget build(BuildContext context) {
    UserDetailProvider userDetailProvider = Provider.of(context);
    UpcomingEventProvider upcomingEventProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar(""),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: whiteColor),
        child: SafeArea(
          child: Center(
            child: Container(
              width: w * 0.9,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: ClipOval(
                                      child: Image.network(
                                    widget.eventModel.eventUserImg,
                                    fit: BoxFit.cover,
                                  )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.eventModel.eventUser),
                                    Text(
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
                                  widget.eventModel.eventDate,
                                  style: TextStyle(
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.eventModel.eventName,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.eventModel.eventDescription,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Requierment",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.eventModel.eventRequirement,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Required Skills",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Wrap(
                            spacing: 10, // Spacing between items
                            runSpacing: 10, // Spacing between rows
                            children: List.generate(
                              widget.eventModel.skills.length,
                              (index) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Text(
                                  widget.eventModel.skills[index],
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "${widget.eventModel.eventCountry}, \n${widget.eventModel.eventState},\n${widget.eventModel.eventCity}."),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Location Landmark",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("${widget.eventModel.eventLandMark}"),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Date & Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.eventModel.eventDate),
                        SizedBox(
                          height: 20,
                        ),
                        if (userDetailProvider.userId !=
                            widget.eventModel.eventOwnerId)
                          MyButton(
                              title: "Im Intrested",
                              width: 1,
                              onclick: () async {
                                QuerySnapshot data = await FirebaseFirestore
                                    .instance
                                    .collection("requestedWorks")
                                    .where("eventId",
                                        isEqualTo: widget.eventModel.eventId)
                                    .where("userId",
                                        isEqualTo: userDetailProvider.userId)
                                    .get();
                                if (data.docs.isNotEmpty) {
                                  MyAlertBox.myShowDialog(context,
                                      "You Aldredy Registered for this event Check out the Status on Profile Section",
                                      () {
                                    MyNavigator.pop(context);
                                  });
                                } else {
                                  upcomingEventProvider.sendRequest(
                                      widget.eventModel.eventId,
                                      userDetailProvider.userId);
                                  MyAlertBox.myShowDialog(context,
                                      "Your enthusiasm has been conveyed to the event organizer.",
                                      () {
                                    MyNavigator.pop(context);
                                  });
                                }
                              })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
