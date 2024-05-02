import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatProvider extends  ChangeNotifier{
  
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<ChatModel> chatRooms = [];

  ChatProvider(){
    getChatRooms();
    notifyListeners();
  }

  TextEditingController messageController = TextEditingController();

  ///this is for convert date
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  getChatRooms() async {
    print("____");
    chatRooms = [];
    QuerySnapshot querySnapshot = await firebaseFirestore.collection("requestedWorks").where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("status",isEqualTo: true).get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for(var i in docs){
      Map<String,dynamic> chatRoom = i.data() as Map<String,dynamic>;
      DocumentSnapshot documentSnapshot = await firebaseFirestore.collection("events").doc(chatRoom['eventId']).get();
      Map<String,dynamic> events = documentSnapshot.data() as Map<String,dynamic>;
      String eventDate = convertDate(DateTime.fromMillisecondsSinceEpoch(events['eventDate']));
      String eventCity = events['eventCity'];
      String eventOwnerName = events['eventUserName'];
      bool eventStatus = events['isEventCompleted'];
      bool isEventCancelled = events['isEventCanceled'];
      ChatModel chatModel = ChatModel(roomCode: chatRoom['eventId'], eventDate: eventDate, eventCity: eventCity, eventOwnerName: eventOwnerName);
      if(!eventStatus && !isEventCancelled)
        {
          chatRooms.add(chatModel);
        }
      notifyListeners();
    }
    notifyListeners();
  }


  sendChat(String roomNumber,BuildContext context,String message)async{
    UserDetailProvider userDetailProvider = Provider.of(context,listen:false);
    await firebaseFirestore.collection(roomNumber).doc().set({
      "message":message,
      "messageTime":DateTime.now().millisecondsSinceEpoch,
      "userId":userDetailProvider.userId,
      "userName":userDetailProvider.userName
    });
    }
}

class ChatModel {
  String roomCode;
  String eventDate;
  String eventCity;
  String eventOwnerName;

  ChatModel({
    required this.roomCode,
    required this.eventDate,
    required this.eventCity,
    required this.eventOwnerName
});
}