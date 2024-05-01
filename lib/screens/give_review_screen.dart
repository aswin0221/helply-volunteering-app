import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_alert_box.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/review_provider.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/main_screen.dart';
import 'package:helply_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';


class GiveReviewScreen extends StatefulWidget {
  final String eventId;
  const GiveReviewScreen({super.key,required this.eventId});

  @override
  State<GiveReviewScreen> createState() => _GiveReviewScreenState();
}

class _GiveReviewScreenState extends State<GiveReviewScreen> {

  @override
  void initState() {
      // TODO: implement initState
      MyEventUploadProvider myEventUploadProvider =
      Provider.of(context, listen: false);
      myEventUploadProvider.getRequestsPeople(widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetailProvider userDetailProvider = Provider.of(context);
    MyEventUploadProvider myEventUploadProvider = Provider.of(context);
    ReviewProvider reviewProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Review Page"),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: whiteColor),
          child: SafeArea(
            child: Center(
              child: Container(
                width: w*0.9,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                child:  Column(
                  children: [
                    Text("${userDetailProvider.userName} Great job completing the event! Please give reviews to your team.❤️",style: TextStyle(fontSize: 18),),
                    Expanded(
                      child: myEventUploadProvider.acceptedPeoples.isEmpty ? const MyLoader(): ListView.builder(
                        itemCount: myEventUploadProvider.acceptedPeoples.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.shade300)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    100)),
                                            child: ClipOval(
                                                child: Image.network(
                                                  myEventUploadProvider.acceptedPeoples[index].profileImage,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(myEventUploadProvider.acceptedPeoples[index].userName),
                                              const Text(
                                                "12 Events Achived",
                                                style: TextStyle(
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            myEventUploadProvider.acceptedPeoples[index].mobileNumber,
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          Icon(
                                            Icons.phone,
                                            color: primaryColor,
                                            size: 18,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  MyTextField(controller: myEventUploadProvider.reviewController[index], hintText: "Review"),
                                  const SizedBox(height: 10,),
                                  MyButton(title: "Confirm", width: 1, onclick: (){
                                    FirebaseFirestore.instance.collection("comments").doc().set({
                                      "userId": myEventUploadProvider.acceptedPeoples[index].userId,
                                      "comment":myEventUploadProvider.reviewController[index].text.trim()
                                    }).then((value) => myEventUploadProvider.reviewController[index].clear());
                                    MyAlertBox.myShowDialog(context,"Review Updated Sucessfully", () {
                                      MyNavigator.pop(context);
                                      myEventUploadProvider.getRequestsPeople(widget.eventId);
                                    });
                                    print("__________________Success");
                                  }),
                                ],
                              ),
                            );
                        },
                      ),
                    ),
                    MyButton(title: "Back to Home", width: 0.5, onclick: (){
                      myEventUploadProvider.acceptedPeoples.forEach((element) {
                        FirebaseFirestore.instance.collection("completedEvents").doc().set({
                          "userId":element.userId,
                          "eventId":widget.eventId
                        }).then((value) {
                          myEventUploadProvider.getMyUploads();
                          MyNavigator.pushReplacementNavigator(context, const MainScreen());
                        });
                      });
                    })
                  ],

                ),
              ),
            ),
          ),
        ));
  }
}
