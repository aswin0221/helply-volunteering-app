import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:intl/intl.dart';

class CompletedEventsProvider extends ChangeNotifier{

  List<EventModel> completedEvents = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  ///this is for convert date
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  CompletedEventsProvider()
  {
    getCompletedEvents();
    notifyListeners();
  }

  ///To get All the completed Events.
  getCompletedEvents()async{
    completedEvents = [];
   QuerySnapshot querySnapshot = await  firebaseFirestore.collection("completedEvents").where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
   List<DocumentSnapshot> docs = querySnapshot.docs;
   for(var i in docs)
     {
       Map<String,dynamic> documentSnap = i.data() as Map<String,dynamic>;
       DocumentSnapshot events = await firebaseFirestore.collection("events").doc( documentSnap['eventId']).get();
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
       EventModel eventModel = EventModel(eventId: eventId, eventName: eventName, eventUser: eventUser, eventUserImg: eventUserImg, eventDate: eventDate, eventDescription: eventDescription, eventTitle: eventTitle, eventCountry: eventCountry, eventState: eventState, eventCity: eventCity, skills: skills, eventRequirement: eventRequirement, eventLandMark: eventLandmark, eventOwnerId: eventOwnerId);
       completedEvents.add(eventModel);
       notifyListeners();
     }
  }

}