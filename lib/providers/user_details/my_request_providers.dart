import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyRequestProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<EventModel> pendingRequest = [];
  List<EventModel> acceptedRequest = [];


  MyRequestProvider(){
    getAllRequest();
    notifyListeners();
  }

  ///this is for convert date
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  ///this is for get all the Requests
  getAllRequest() async {
    pendingRequest = [];
    acceptedRequest = [];
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("requestedWorks")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for (var i in docs) {
      Map<String, dynamic> request = i.data() as Map<String, dynamic>;
      if (request['status'] == true) {
        DocumentSnapshot events = await firebaseFirestore.collection("events").doc(request['eventId']).get();
        String eventUser = events['eventUserName'];
        String eventUserImg = events['eventUserPicture'];
        String eventId = events['eventId'];
        String eventName=events['eventName'];
        String eventDate = convertDate(DateTime.fromMillisecondsSinceEpoch(events['eventDate']));
        String eventDescription=events['eventDescription'];
        String eventTitle = events["eventName"];
        String eventCountry = events["eventNation"];
        String eventState = events['eventState'];
        String eventCity = events['eventCity'];
        String eventLandmark = events['eventLandmark'];
        List<dynamic> skills = events["eventRequiredSkills"];
        String eventOwnerId = events['eventOwnerId'];
        String eventRequirement = events["eventRequirements"];
        bool eventStatus = events['isEventCompleted'];
        bool isEventCancelled = events['isEventCanceled'];
        EventModel eventModel = EventModel(eventId: eventId, eventName: eventName, eventUser: eventUser, eventUserImg: eventUserImg, eventDate: eventDate, eventDescription: eventDescription, eventTitle: eventTitle, eventCountry: eventCountry, eventState: eventState, eventCity: eventCity, skills: skills, eventRequirement: eventRequirement, eventLandMark: eventLandmark, eventOwnerId: eventOwnerId);
        if(!eventStatus && !isEventCancelled)
          {
            acceptedRequest.add(eventModel);
          }
        notifyListeners();
      } else if (request['status'] == false) {
        DocumentSnapshot events = await firebaseFirestore.collection("events").doc(request['eventId']).get();
        String eventUser = events['eventUserName'];
        String eventUserImg = events['eventUserPicture'];
        String eventId = events['eventId'];
        String eventName=events['eventName'];
        String eventDate = convertDate(DateTime.fromMillisecondsSinceEpoch(events['eventDate']));
        String eventDescription=events['eventDescription'];
        String eventTitle = events["eventName"];
        String eventCountry = events["eventNation"];
        String eventState = events['eventState'];
        String eventCity = events['eventCity'];
        String eventLandmark = events['eventLandmark'];
        List<dynamic> skills = events["eventRequiredSkills"];
        String eventOwnerId = events['eventOwnerId'];
        String eventRequirement = events["eventRequirements"];
        bool eventStatus = events['isEventCompleted'];
        bool isEventCancelled = events['isEventCanceled'];
        EventModel eventModel = EventModel(eventId: eventId, eventName: eventName, eventUser: eventUser, eventUserImg: eventUserImg, eventDate: eventDate, eventDescription: eventDescription, eventTitle: eventTitle, eventCountry: eventCountry, eventState: eventState, eventCity: eventCity, skills: skills, eventRequirement: eventRequirement, eventLandMark: eventLandmark, eventOwnerId: eventOwnerId);
        if(!eventStatus && !isEventCancelled)
        {
          pendingRequest.add(eventModel);
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }




}
