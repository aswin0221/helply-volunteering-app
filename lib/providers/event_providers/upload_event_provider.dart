import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UploadEventProvider extends ChangeNotifier {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController eventName = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController eventRequirements = TextEditingController();
  TextEditingController eventLandMark = TextEditingController();


  List<String> selectedSkills=[];
  List<int> selectedIndex=[];
  int eventDate=0;
  String selectDate = "Select Event Date";
  String selectSkills = "select Required skills";
  DateTime? eventTime;

  String? countryValue;
  String? stateValue;
  String? cityValue;

  bool isLoading = false;

  List<String> skillsOptions = [
    "Empathy",
    "Active listening",
    "Communication",
    "Compassion",
    "Patience",
    "Flexibility",
    "Adaptability",
    "Interpersonal",
    "Advocacy",
    "Problem-solving",
    "Organization",
    "Leadership",
    "Teamwork",
    "Cultural competency",
    "Confidentiality",
    "Respectfulness",
    "Resourcefulness",
    "Sensitivity",
    "Empowerment",
    "Resilience",
  ];

  addSkills(String skill , int index)
  {
    selectedSkills.add(skill);
    selectedIndex.add(index);
    notifyListeners();
  }

  datePicker(BuildContext context)
  {
    BottomPicker.dateTime(
      pickerTitle: const Text('schedule Your Work',style :TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.white,
      )),
      onSubmit: (date) {
        Fluttertoast.showToast(
            msg: "Date Selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            textColor: Colors.white,
            fontSize: 16.0
        );
        eventTime = date;
        selectDate = convertDate(eventTime!);
        eventDate = eventTime!.millisecondsSinceEpoch;
        notifyListeners();
      },
      onClose: () {
      },
      minDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 60)),
      initialDateTime:DateTime.now(),
      backgroundColor: Colors.white,
      buttonSingleColor: const Color(0xff3475db),
    ).show(context);
  }


  uploadEvent(BuildContext context) async {
    UserDetailProvider userDetailProvider = Provider.of(context,listen: false);
    isLoading = true;
    notifyListeners();
    String docId =  firebaseFirestore.collection("events").doc().id;
    firebaseFirestore.collection("events").doc(docId).set({
      "eventId" : docId,
      "eventUserName":userDetailProvider.userName,
      "eventUserPicture":userDetailProvider.profileImage,
      "eventOwnerId" :FirebaseAuth.instance.currentUser!.uid,
      "eventName":eventName.text.trim(),
      "eventDescription":eventDescription.text.trim(),
      "eventRequirements":eventRequirements.text.trim(),
      "eventRequiredSkills": selectedSkills,
      "eventLandmark": eventLandMark.text.trim(),
      "eventNation": countryValue,
      "eventState":stateValue,
      "eventDate":eventDate,
      "eventCity":cityValue,
      "isEventCompleted":false,
      "isEventCanceled":false
    }).then((value) {
      firebaseFirestore.collection("chats").doc("groupChats").collection(docId).doc().set({
        "message":"Hello Welcome everyone....",
        "messageTime":DateTime.now().millisecondsSinceEpoch,
        "userId":FirebaseAuth.instance.currentUser!.uid
      }).then((value){
        eventName.clear();
        eventRequirements.clear();
        eventLandMark.clear();
        eventDescription.clear();
        eventDate = 0;
        selectDate = "Select Event Date";
        notifyListeners();
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message:
            "Event Uploaded Successfully",
          ),
        );
        isLoading = false;
        notifyListeners();
      });
    });
  }

  bool validate(BuildContext context)
  {
    if(eventName.text.trim().isNotEmpty && eventDescription.text.isNotEmpty && eventRequirements.text.isNotEmpty && eventLandMark.text.isNotEmpty && eventDate!=0 &&  selectedSkills.isNotEmpty)
      {
        return true;
      }
    else
      {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message:
            "All fields are manratory",
          ),
        );
        return false;
      }
  }

  ///Helpers
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat("d`MMM h:mm a").format(dateTime);
    return formattedDate;
  }
}