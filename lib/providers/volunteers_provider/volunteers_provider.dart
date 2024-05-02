

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VolunteersProvider extends ChangeNotifier{

  TextEditingController citySearchController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<UsersModel> allUsers = [];

  VolunteersProvider(){
    getAllUsers();
    notifyListeners();
  }

  getAllUsers()async {
    QuerySnapshot querySnapshot = await firebaseFirestore.collection("users").get();
    List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;
    for(var i in documentSnapshots)
      {
        Map<String,dynamic> user = i.data() as Map<String,dynamic>;
        if(user['isActivevolunteer'])
          {
            String userId = user['userId'];
            String userName = user['userName'];
            String email = user['email'];
            String mobileNumber = user['mobileNumber'];
            String profileImage = user['profileImage'];
            String about = user['about'];
            List skills = user['skills'];
            String emergencyContact = user['emergencyContact'];
            bool isActivevolunteer = user['isActivevolunteer'];
            bool isBloodDonor = user['isBloodDonor'];
            String bloodGroup = user['bloodGroup'];
            String userCountry = user['country'];
            String userState = user['state'];
            String userCity = user['city'];
            QuerySnapshot querySnapshot = await firebaseFirestore.collection("completedEvents").where("userId",isEqualTo: userId).get();
            List<DocumentSnapshot> docs = querySnapshot.docs;
            int completedEvents = docs.length;
            UsersModel usersModel = UsersModel(userId: userId, userName: userName, email: email, mobileNumber: mobileNumber, profileImage: profileImage, about: about, skills: skills, emergencyContact: emergencyContact, isActiveVolunteer: isActivevolunteer, isBloodDonor: isBloodDonor, bloodGroup: bloodGroup, userCountry: userCountry, userState: userState, userCity: userCity,userCompletedEvents: completedEvents);
            allUsers.add(usersModel);
            notifyListeners();
          }
      }
  }

}


class UsersModel {
  String userId;
  String userName;
  String email;
  String mobileNumber;
  String profileImage;
  String about;
  List skills;
  String emergencyContact;
  bool isActiveVolunteer;
  bool isBloodDonor;
  String bloodGroup;
  String userCountry;
  String userState;
  String userCity;
  int userCompletedEvents;
  String requestDocId;

  UsersModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.profileImage,
    required this.about,
    required this.skills,
    required this.emergencyContact,
    required this.isActiveVolunteer,
    required this.isBloodDonor,
    required this.bloodGroup,
    required this.userCountry,
    required this.userState,
    required this.userCompletedEvents,
    required this.userCity,
    this.requestDocId = ""
  });
}
