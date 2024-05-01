import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpcomingEventProvider extends ChangeNotifier {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  int currentPosition =0;
  bool aldredyVisited = false;


  
  sendRequest(String eventId,String userId)
  {
    firebaseFirestore.collection("requestedWorks").doc().set({
      "eventId":eventId,
      "userId":userId,
      "status":false
    });
  }

}

class EventModel {
  String eventName;
  String eventUser;
  String eventOwnerId;
  String eventUserImg;
  String eventDate;
  String eventDescription;
  String eventTitle;
  String eventCountry;
  String eventState;
  String eventCity;
  String eventId;
  String eventLandMark;
  List<dynamic> skills;
  String eventRequirement;
  int eventDateInMilli;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventUser,
    required this.eventUserImg,
    required this.eventDate,
    required this.eventDescription,
    required this.eventTitle,
    required this.eventCountry,
    required this.eventState,
    required this.eventCity,
    required this.skills,
    required this.eventRequirement,
    required this.eventLandMark,
    required this.eventOwnerId,
    this.eventDateInMilli = 0
  });
}

