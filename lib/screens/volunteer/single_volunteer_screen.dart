import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/providers/user_details/user_review_provider.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SingleVolunteerScreen extends StatefulWidget {
  final UsersModel usersModel;
  const SingleVolunteerScreen({super.key,required this.usersModel});

  @override
  State<SingleVolunteerScreen> createState() => _SingleVolunteerScreenState();
}

class _SingleVolunteerScreenState extends State<SingleVolunteerScreen> {

  @override
  void initState() {
    // TODO: implement initState
    UserReviewProvider userReviewProvider = Provider.of(context,listen: false);
    userReviewProvider.getUserReview(widget.usersModel.userId);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    UserReviewProvider userReviewProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: myAppBar("Active Volunteers"),
        backgroundColor: Colors.teal,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: whiteColor,
          ),
          child: Center(
            child: Container(
              width: w*0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Colors.grey,
                      border: Border.all(color: primaryColor)
                    ),
                    child: ClipOval(child: Image.network(widget.usersModel.profileImage,fit: BoxFit.cover,)),
                  ),
                   Text(widget.usersModel.userName,style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 5,),
                   Center(
                    child: Text(
                      "\u275D  ${widget.usersModel.about}  \u275E",
                      style: TextStyle(color: Colors.black87, fontSize: 12),
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
                            Text("50",style: TextStyle(fontWeight: FontWeight.bold),),
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
                            widget.usersModel.isActiveVolunteer ? Icon(Icons.check) : Icon(Icons.cancel_presentation_outlined),
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
                            widget.usersModel.isBloodDonor ? Icon(Icons.check) : Icon(Icons.cancel_presentation_outlined),
                            Text("Active \nVolunteer",style: TextStyle(color:primaryColor),textAlign: TextAlign.center,)
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.phone,size: 15,),
                            SizedBox(width: 5,),
                            Text("Mobile Number"),
                          ],
                        ),
                        Text("     ${widget.usersModel.mobileNumber}"),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.phone,size: 15,),
                            SizedBox(width: 5,),
                            Text("Emergency contact"),
                          ],
                        ),
                        Text("     ${widget.usersModel.emergencyContact}"),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.location_pin,size: 15,),
                            SizedBox(width: 5,),
                            Text("Address"),
                          ],
                        ),
                        Text("     ${widget.usersModel.userCity} \n     ${widget.usersModel.userState} \n     ${widget.usersModel.userCountry}"),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Container(
                                  width: w,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.black54,
                                        ),
                                        child: Text(""),
                                      ),
                                      SizedBox(height: 5,),
                                      Expanded(
                                        child: userReviewProvider.allComments.isEmpty ? const Text("No Reviews") : ListView.builder(
                                          itemCount:userReviewProvider.allComments.length,
                                          itemBuilder: (context,index){
                                            return Container(
                                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                child: Column(
                                                  children: [
                                                    Text(userReviewProvider.allComments[index]),
                                                    Divider()
                                                  ],
                                                ));
                                          }
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      );
                    },
                    child: Text("Check Reviews",style: TextStyle(color: Colors.white),),
                    color: primaryColor,
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
