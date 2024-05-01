import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserReviewProvider extends ChangeNotifier {

  List<String> allComments = [];
  
  getUserReview(String userId) async {
    allComments =[];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("comments").where("userId",isEqualTo: userId).get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for(var i in docs)
      {
        Map<String,dynamic> comments = i.data() as Map<String,dynamic>;
        allComments.add(comments['comment']);
        notifyListeners();
      }
  }

}