import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:intl/intl.dart';

class MyEventUploadProvider extends ChangeNotifier {
  
  List<EventModel> myUploads = [];
  List<EventModel> checkCompleteStatus = [];
  List<UsersModel> requestPeoples = [];
  List<UsersModel> acceptedPeoples = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<TextEditingController> reviewController =[];

  ///this is for convert date
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  MyEventUploadProvider(){
    getMyUploads();
    notifyListeners();
  }



  getMyUploads()async{
    myUploads = [];
    QuerySnapshot querySnapshot = await  firebaseFirestore.collection("events").where("eventOwnerId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for(var i in docs)
      {
        Map<String,dynamic> events = i.data() as Map<String,dynamic>;
        String eventUser = events['eventUserName'];
        String eventUserImg = events['eventUserPicture'];
        String eventId = events['eventId'];
        String eventName=events['eventName'];
        String eventDate = convertDate(DateTime.fromMillisecondsSinceEpoch(events['eventDate']));
        int eventDateInMilli = events['eventDate'];
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
        EventModel eventModel = EventModel(eventId: eventId, eventName: eventName, eventUser: eventUser, eventUserImg: eventUserImg, eventDate: eventDate, eventDescription: eventDescription, eventTitle: eventTitle, eventCountry: eventCountry, eventState: eventState, eventCity: eventCity, skills: skills, eventRequirement: eventRequirement, eventLandMark: eventLandmark, eventOwnerId: eventOwnerId,eventDateInMilli: eventDateInMilli);
        if(!isEventCancelled)
          {
            if(eventDateInMilli>DateTime.now().millisecondsSinceEpoch)
            {
              myUploads.add(eventModel);
            }
            else if(eventDateInMilli<DateTime.now().millisecondsSinceEpoch && !eventStatus)
            {
              checkCompleteStatus.add(eventModel);
            }
          }
        notifyListeners();
      }
  }
  
  getRequestsPeople(String eventId) async {
    print("+++++++++++++++stated");
    requestPeoples = [];
    acceptedPeoples = [];
    reviewController=[];
    QuerySnapshot querySnapshot = await firebaseFirestore.collection("requestedWorks").where("eventId",isEqualTo: eventId).get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for(var i in docs)
      {
        String docId = i.id;
        Map<String,dynamic> requests = i.data() as Map<String,dynamic>;
        DocumentSnapshot user = await firebaseFirestore.collection("users").doc(requests['userId']).get();
        String userId = user['userId'] ?? "";
        String userName = user['userName']?? "";
        String email = user['email']?? "";
        String mobileNumber = user['mobileNumber']?? "";
        String profileImage = user['profileImage']?? "";
        String about = user['about']?? "";
        List skills = user['skills'] ?? [];
        String emergencyContact = user['emergencyContact']?? "";
        bool isActivevolunteer = user['isActivevolunteer'] ?? false;
        bool isBloodDonor = user['isBloodDonor'] ?? false;
        String bloodGroup = user['bloodGroup']?? "";
        String userCountry = user['country']?? "";
        String userState = user['state']?? "";
        String userCity = user['city']?? "";
        QuerySnapshot querySnapshot = await firebaseFirestore.collection("completedEvents").where("userId",isEqualTo: userId).get();
        List<DocumentSnapshot> docs = querySnapshot.docs;
        int completedEvents = docs.length;
        UsersModel usersModel =  UsersModel(userId: userId, userName: userName, email: email, mobileNumber: mobileNumber, profileImage: profileImage, about: about, skills: skills, emergencyContact: emergencyContact, isActiveVolunteer: isActivevolunteer, isBloodDonor: isBloodDonor, bloodGroup: bloodGroup, userCountry: userCountry, userState: userState, userCity: userCity,requestDocId: docId,userCompletedEvents: completedEvents);
        if(requests['status'])
          {
            acceptedPeoples.add(usersModel);
            reviewController.add(TextEditingController());
            notifyListeners();
          }
        else if(!requests['status'])
          {
            requestPeoples.add(usersModel);
            notifyListeners();
          }
        notifyListeners();
      }
    print(acceptedPeoples);
    print("+++++++++++++++ended");
  }
  
}