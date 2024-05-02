import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/chat_provider.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/user_details/completed_events_provider.dart';
import 'package:helply_app/providers/user_details/my_request_providers.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:helply_app/screens/CheckCompletedEvents.dart';
import 'package:helply_app/screens/auth/login_screen.dart';
import 'package:helply_app/screens/chat/chat_room.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List carousal = ["assets/carousal/c1.jpg","assets/carousal/c2.jpg","assets/carousal/c3.jpg","assets/carousal/c4.jpg","assets/carousal/c5.jpg"];
  String _getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    UpcomingEventProvider upcomingEventProvider = Provider.of(context,listen: false);
    VolunteersProvider volunteersProvider = Provider.of(context,listen: false);
    MyRequestProvider myRequestProvider = Provider.of(context,listen: false);
    CompletedEventsProvider completedEventsProvider = Provider.of(context,listen: false);
    MyEventUploadProvider myEventUploadProvider = Provider.of(context,listen: false);
    ChatProvider chatProvider = Provider.of(context,listen: false);

      Future.delayed(const Duration(seconds: 5),() {
        if(myEventUploadProvider.checkCompleteStatus.isNotEmpty){
          MyNavigator.pushNavigator(context, const CheckCompletedEvents());
        }
      },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetailProvider userDetailProvider = Provider.of(context);
    ChatProvider chatProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${userDetailProvider.userName}",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(_getGreeting()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CarouselSlider.builder(
                      itemCount: carousal.length,
                      itemBuilder:
                          (BuildContext context, int itemIndex, int pageViewIndex) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: ClipRRect(
                               borderRadius: BorderRadius.circular(15),
                              child: Image.asset(carousal[itemIndex],fit:BoxFit.cover,)),
                        );
                      },
                      options: CarouselOptions(
                          height: 150,
                          viewportFraction: 0.7,
                          enlargeCenterPage: true,
                          autoPlay: true,
                        animateToClosest: true,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        "\u275D  Empower Change, Inspire Hearts \nVolunteer with Purpose  \u275E",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
                      child: Divider(color: Colors.grey.shade400,),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Upcoming Work Remainders",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                            Icon(Icons.notifications,size: 18,color: primaryColor,)
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    )),
                    Expanded(
                      child: chatProvider.chatRooms.isEmpty ? MyLoader() : ListView.builder(
                        itemCount: chatProvider.chatRooms.length,
                        itemBuilder: (context, index){
                          return  GestureDetector(
                            onTap: (){
                              MyNavigator.pushNavigator(context, ChatRoom(roomCode: chatProvider.chatRooms[index].roomCode,));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 20, // Increased blur radius
                                      offset: Offset(0, 4),
                                    )
                                  ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${chatProvider.chatRooms[index].eventOwnerName} ' Event",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("${chatProvider.chatRooms[index].eventDate} | ${chatProvider.chatRooms[index].eventCity}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Chat",style: TextStyle(color:primaryColor,fontWeight: FontWeight.bold),),
                                      Icon(Icons.arrow_forward_ios,size: 15,color: primaryColor,)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
