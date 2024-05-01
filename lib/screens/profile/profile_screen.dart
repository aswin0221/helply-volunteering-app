import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_alert_box.dart';
import 'package:helply_app/helpers/my_local_database.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/others/bottom_navbar_provider.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/auth/login_screen.dart';
import 'package:helply_app/screens/profile/completed_activity_screen.dart';
import 'package:helply_app/screens/profile/my_event_uploads.dart';
import 'package:helply_app/screens/profile/my_request_screen.dart';
import 'package:helply_app/screens/profile/requested_peoples_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    UserDetailProvider userDetailProvider = Provider.of(context);
    MyEventUploadProvider myEventUploadProvider = Provider.of(context);
    BottomNavBarProvider barProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor:primaryColor ,
        appBar: myAppBar("My Account"),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: whiteColor,
          ),
          child: Center(
            child: SizedBox(
              width: w*0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        border: Border.all(color: primaryColor),
                        color: Colors.grey,
                      ),
                      child:ClipOval(child: Image.network(userDetailProvider.profileImage,fit:BoxFit.cover,)),
                    ),
                    Text(userDetailProvider.userName,style: const TextStyle(fontSize: 18),),
                    const SizedBox(height: 5,),
                     Center(
                      child: Text(
                        "\u275D ${userDetailProvider.about}  \u275E",
                        style: const TextStyle(color: Colors.black87, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Column(
                            children: [
                               Text(userDetailProvider.completedEvents.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Total \nWorks",style: TextStyle(color:primaryColor ),textAlign: TextAlign.center,)
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey,
                            child: const Text(""),
                          ),
                           Column(
                            children: [
                              userDetailProvider.isBloodDonor ? const Icon(Icons.check) : const Icon(Icons.cancel_presentation_outlined),
                              Text("Blood \nDoor",style: TextStyle(color:primaryColor),textAlign: TextAlign.center,)
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey,
                            child: const Text(""),
                          ),
                           Column(
                            children: [
                              userDetailProvider.isActivevolunteer ? const Icon(Icons.check) : const Icon(Icons.cancel_presentation_outlined),
                              Text("Active \nVolunteer",style: TextStyle(color:primaryColor),textAlign: TextAlign.center,)
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            MyNavigator.pushNavigator(context,const MyEventUploads());
                          },
                          child: Container(
                            width: w,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Row(
                              children: [
                                Icon(Icons.event,size: 18,),
                                SizedBox(width: 5,),
                                Text("My Event Uploads"),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: (){
                            MyNavigator.pushNavigator(context, const CompletedEventsScreen());
                          },
                          child: Container(
                            width: w,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Row(
                              children: [
                                Icon(Icons.event_available_sharp,size: 18,),
                                SizedBox(width: 5,),
                                Text("Completed Events"),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: (){
                            MyNavigator.pushNavigator(context, const MyRequestScreen());
                          },
                          child: Container(
                            width: w,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Row(
                              children: [
                                Icon(Icons.question_answer_outlined,size: 18,),
                                SizedBox(width: 5,),
                                Text("Our Requests"),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: (){
                            MyLocalStorage.setBool("isLogin", false);
                            barProvider.currentIndex=0;
                            MyNavigator.pushReplacementNavigator(context, const LoginScreen());
                          },
                          child: Container(
                            width: w,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Row(
                              children: [
                                Icon(Icons.logout,size: 18,),
                                SizedBox(width: 5,),
                                Text("Logout",style: TextStyle(color: Colors.redAccent),),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
