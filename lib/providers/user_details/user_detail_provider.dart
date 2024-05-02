import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String userId = "";
  String userName = "";
  String email = "";
  String mobileNumber = "";
  String profileImage = "";
  String about = "";
  List skills = [];
  String emergencyContact = "";
  bool isActivevolunteer = false;
  bool isBloodDonor = false;
  String bloodGroup = "";
  String userCountry ="";
  String userState = "";
  String userCity = "";
  int completedEvents = 0;



  UserDetailProvider() {
    getUserDetails();
    notifyListeners();
  }


  getUserDetails() async
  {
    DocumentSnapshot userData = await firebaseFirestore.collection("users").doc(
        FirebaseAuth.instance.currentUser!.uid).get();
    Map<String, dynamic> user = userData.data() as Map<String, dynamic>;
    userId = user['userId'];
    userName = user['userName'];
    email = user['email'];
    mobileNumber = user['mobileNumber'];
    profileImage = user['profileImage'];
    about = user['about'];
    skills = user['skills'];
    emergencyContact = user['emergencyContact'];
    isActivevolunteer = user['isActivevolunteer'];
    isBloodDonor = user['isBloodDonor'];
    bloodGroup = user['bloodGroup'];
    userCountry = user['country'];
    userState = user['state'];
    userCity = user['city'];
    print("_________________________________Completed");
    QuerySnapshot querySnapshot = await firebaseFirestore.collection("completedEvents").where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    completedEvents = docs.length;
    notifyListeners();
  }
  
  
  getChats()async{
    DocumentSnapshot documentSnapshot = await firebaseFirestore.collection("chats").doc("groupChats").get();
    print(documentSnapshot.data());
  }

}