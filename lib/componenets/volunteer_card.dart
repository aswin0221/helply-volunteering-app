import 'package:flutter/material.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:helply_app/screens/volunteer/single_volunteer_screen.dart';
import 'package:line_icons/line_icon.dart';

class VolunteerCard extends StatefulWidget {
  final UsersModel usersModel;
  const VolunteerCard({super.key,required this.usersModel});

  @override
  State<VolunteerCard> createState() => _VolunteerCardState();
}

class _VolunteerCardState extends State<VolunteerCard> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        MyNavigator.pushNavigator(context,  SingleVolunteerScreen(usersModel: widget.usersModel,));
      },
      child: Stack(
        children: [
          Container(
            width: 150,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(1,1),
                  spreadRadius:1,
                  blurRadius: 10
                )
              ]
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: ClipOval(child: Image.network(widget.usersModel.profileImage,fit: BoxFit.cover,)),
                ),
                const SizedBox(height: 10,),
                 Text(widget.usersModel.userName,style: TextStyle(fontWeight: FontWeight.bold,),),
                const SizedBox(height: 5,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("12 Events Achived",style: TextStyle(fontSize: 12),)
                  ],
                ),
                const SizedBox(height: 5,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LineIcon.phone(size: 18,),
                    SizedBox(width: 5,),
                    Text(widget.usersModel.mobileNumber),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Read More",style: TextStyle(fontSize: 12,color: primaryColor),),
                    Icon(Icons.arrow_forward_ios,size: 12,color: primaryColor,)
                  ],
                )
              ],
            ),
          ),
          if(widget.usersModel.isBloodDonor)
            Positioned(
                top: 0,
                right: 30,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: const Text("Blood Donor",style: TextStyle(fontSize: 10,color: Colors.white),))),
        ],
      ),
    );
  }
}
