import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/user_details/completed_events_provider.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CompletedEventsScreen extends StatefulWidget {
  const CompletedEventsScreen({super.key});

  @override
  State<CompletedEventsScreen> createState() => _CompletedEventsScreenState();
}

class _CompletedEventsScreenState extends State<CompletedEventsScreen> {

  ///this is for date conversion
  String convertDate(DateTime dateTime) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    return formattedDate;
  }
  Map<String , dynamic> events={};
  int totalEvents = 0;

  bool loader = false;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1),() {
      loader = false;
      setState(() {
      });
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetailProvider userDetailProvider = Provider.of(context);
    CompletedEventsProvider completedEventsProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar("Completed Events"),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          color: whiteColor,
        ),
        child: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: w*0.9,
              child: Column(
                children: [
                  Text("${completedEventsProvider.completedEvents.length.toString()} Volunteering Milestones\nMaking a Difference ♥️",textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w500),),
                  Expanded(
                    child: completedEventsProvider.completedEvents.isEmpty ? const MyLoader(): ListView.builder(
                      itemCount: completedEventsProvider.completedEvents.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100)
                                        )
                                        ,child: ClipOval(child: Image.network(completedEventsProvider.completedEvents[index].eventUserImg,fit: BoxFit.cover,)),
                                      ),
                                      const SizedBox(width: 5,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(completedEventsProvider.completedEvents[index].eventUser),
                                          const Text("12 Events Achived",style: TextStyle(fontSize: 10),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(completedEventsProvider.completedEvents[index].eventDate,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                      Icon(Icons.bookmark,color: primaryColor,size: 18,)
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Text(completedEventsProvider.completedEvents[index].eventName)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
