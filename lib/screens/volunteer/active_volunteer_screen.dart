import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/componenets/volunteer_card.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class ActiveVolunteerScreen extends StatefulWidget {
  const ActiveVolunteerScreen({super.key});

  @override
  State<ActiveVolunteerScreen> createState() => _ActiveVolunteerScreenState();
}

class _ActiveVolunteerScreenState extends State<ActiveVolunteerScreen> {
  @override
  Widget build(BuildContext context) {
    VolunteersProvider volunteersProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: myAppBar("Active Volunteers"),
          backgroundColor: Colors.teal,
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: whiteColor,
            ),
            child: Center(
              child: Container(
                width: w * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Expanded(
                      child: Center(
                        child: PaginateFirestore(
                          //item builder type is compulsory.
                          itemBuilder: (context, documentSnapshots, index) {
                            final user = documentSnapshots[index].data() as Map?;
                            String userId = user!['userId'];
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

                            UsersModel usersModel = UsersModel(
                                userId: userId,
                                userName: userName,
                                email: email,
                                mobileNumber: mobileNumber,
                                profileImage: profileImage,
                                about: about,
                                skills: skills,
                                emergencyContact: emergencyContact,
                                isActiveVolunteer: isActivevolunteer,
                                isBloodDonor: isBloodDonor,
                                bloodGroup: bloodGroup,
                                userCountry: userCountry,
                                userState: userState,
                                userCity: userCity,
                              userCompletedEvents: 3
                            );
                            return VolunteerCard(usersModel: usersModel);
                          },
                          // orderBy is compulsory to enable pagination
                          query: FirebaseFirestore.instance
                              .collection('users')
                              .where("isActivevolunteer", isEqualTo: true),
                          //Change types accordingly
                          itemBuilderType: PaginateBuilderType.gridView,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 1.3),
                          ),
                          isLive: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
