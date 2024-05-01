import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/profile/requested_peoples_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyEventUploads extends StatefulWidget {
  const MyEventUploads({super.key});

  @override
  State<MyEventUploads> createState() => _MyEventUploadsState();
}

class _MyEventUploadsState extends State<MyEventUploads> {
  @override
  Widget build(BuildContext context) {
    MyEventUploadProvider myEventUploadProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar("My Event Uploads"),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          color: whiteColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                child: myEventUploadProvider.myUploads.isEmpty ? const MyLoader() : ListView.builder(
                  itemCount: myEventUploadProvider.myUploads.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
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
                                    ,child: ClipOval(child: Image.network(myEventUploadProvider.myUploads[index].eventUserImg,fit: BoxFit.cover,)),
                                  ),
                                  const SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(myEventUploadProvider.myUploads[index].eventUser),
                                      const Text("12 Events Achived",style: TextStyle(fontSize: 10),)
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(myEventUploadProvider.myUploads[index].eventDate,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                  Icon(Icons.bookmark,color: primaryColor,size: 18,)
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Text(myEventUploadProvider.myUploads[index].eventTitle,style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text(myEventUploadProvider.myUploads[index].eventDescription),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(onPressed: (){
                                MyNavigator.pushNavigator(context,  RequestedPersonsScreen(eventId: myEventUploadProvider.myUploads[index].eventId));
                              },color: primaryColor,child: const Text("Intrested Peoples",style: TextStyle(color: Colors.white),),)
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
