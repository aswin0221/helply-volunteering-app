import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/screens/auth/verify_email_Screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emergencyMobileNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  File? profilePicture;
  PlatformFile? pickedImgFile;

  List selectedIndex = [];
  bool activeVolunteer = false;
  bool bloodDonor = false;
  String bloodGroup = "";
  List<String> mySkills = [];
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

  String countryValue ="";
  String stateValue = "";
  String cityValue ="";

  PageController pageController = PageController();

  changePage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut, // Adjust the curve as needed
    );
  }

  addSkills(String skill, int index) {
    mySkills.add(skill);
    selectedIndex.add(index);
    notifyListeners();
  }

  ///For pick Image Icon File from mobile
  Future<void> pickImage() async {
    final imgFile = await FilePicker.platform.pickFiles(type: FileType.image);
    if (imgFile != null && imgFile.files.isNotEmpty) {
      pickedImgFile = imgFile.files.first;
      profilePicture = File(imgFile.paths.first ?? "");
    }
    notifyListeners();
  }


  createAccount(BuildContext context) async {
    try {
      isLoading = true;
        await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()).then((value) {
        uploadUserDetails();
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message:
            "Account Created Successfully!",
          ),
        );
        MyNavigator.pushNavigator(context, const VerifyEmailScreen());
        isLoading = false;
      });
        notifyListeners();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      String errorMessage = "An unknown error occurred";
      switch (e.code) {
        case 'invalid-email':
          errorMessage = "Invalid email";
          break;
        case 'user-not-found':
          errorMessage = "User not found";
          break;
        case 'wrong-password':
          errorMessage = "Wrong password";
          break;
        case 'network-request-failed':
          errorMessage = "Network error";
          break;
        case 'user-disabled':
          errorMessage = "User disabled";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Try again later.";
          break;
      }
      showTopSnackBar(
        Overlay.of(context),
         CustomSnackBar.error(
          message:errorMessage,
        ),
      );
    }
  }


  ///to save userDetails to firebase
  uploadUserDetails()async
  {
    final ref =  firebaseStorage.ref("profilePicture").child("${DateTime.now().millisecondsSinceEpoch}.jpg");
    await ref.putFile(profilePicture!);
    final String url = await ref.getDownloadURL();
    firebaseFirestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "userId" : FirebaseAuth.instance.currentUser!.uid,
      "userName":nameController.text.trim(),
      "email":emailController.text.trim(),
      "country":countryValue,
      "state":stateValue,
      "city":cityValue,
      "mobileNumber": mobileController.text.trim(),
      "profileImage":url,
      "about":aboutController.text.trim(),
      "skills":mySkills,
      "emergencyContact":emergencyMobileNumber.text.trim(),
      "isActivevolunteer":activeVolunteer,
      "isBloodDonor":bloodDonor,
      "bloodGroup":bloodGroup
    });
  }

  ///Upload a file to Firebase cloud
  Future<String> uploadFile(File file,String folder , String fileName) async{
    final ref =  firebaseStorage.ref(folder).child(fileName);
    await ref.putFile(file);
    final String url = await ref.getDownloadURL();
    return  url;
  }


  ///validate page 1
   bool validatePageOne(BuildContext context)
   {
     if(nameController.text.trim().isNotEmpty && mobileController.text.trim().isNotEmpty && emergencyMobileNumber.text.trim().isNotEmpty && countryValue.isNotEmpty && stateValue.isNotEmpty && cityValue.isNotEmpty){
       return true;
     }
     else
       {
         showTopSnackBar(
           Overlay.of(context),
           const CustomSnackBar.error(
             message:"All fields are mandedtory",
           ),
         );
         return false;
       }
   }

  ///validate page 2
  bool validatePageTwo(BuildContext context)
  {
    if(aboutController.text.trim().isNotEmpty && mySkills.isNotEmpty){
      return true;
    }
    else
    {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message:"All fields are mandedtory",
        ),
      );
      return false;
    }
  }

  ///validate page3
  bool validatePageThree(BuildContext context)
  {
    if(emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty){
      return true;
    }
    else
    {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message:"All fields are mandedtory",
        ),
      );
      return false;
    }
  }


  ///SendVe

}
