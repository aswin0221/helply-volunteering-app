
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/providers/event_providers/upload_event_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UploadEventScreen extends StatefulWidget {
  const UploadEventScreen({super.key});

  @override
  State<UploadEventScreen> createState() => _UploadEventScreenState();
}

class _UploadEventScreenState extends State<UploadEventScreen> {
  @override
  Widget build(BuildContext context) {
    UploadEventProvider uploadEventProvider = Provider.of(context,listen: true);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: myAppBar("Upload Event"),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: whiteColor,
          ),
          child: Center(
            child: Stack(
              children: [
                // Opacity(
                //   opacity:0.2,
                //   child: Align(
                //     alignment: Alignment.topRight,
                //       child: Lottie.asset("assets/lottie/helping.json",width: 150)),
                // ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: w*0.9,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50,),
                          //Text("Inspire positive change, \ncreate impact.",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,),
                          const SizedBox(height: 20,),
                          Text("Register Form",style: TextStyle(fontSize: 18,color: primaryColor),),
                          const SizedBox(height: 5,),
                          MyTextField(controller:uploadEventProvider.eventName, hintText: "Event Name"),
                          const SizedBox(height: 5,),
                          MyTextField(controller:uploadEventProvider.eventDescription, hintText: "Event Description"),
                          const SizedBox(height: 5,),
                          MyTextField(controller: uploadEventProvider.eventRequirements , hintText: "Event Requirements"),
                          const SizedBox(height: 5,),
                          GestureDetector(
                            onTap: () {
                              uploadEventProvider.selectedIndex = [];
                              uploadEventProvider.selectedSkills = [];
                              setState(() {});
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Container(
                                          width: w,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.black54,
                                                ),
                                                child: Text(""),
                                              ),
                                              SizedBox(height: 10,),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: uploadEventProvider.skillsOptions.length,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          uploadEventProvider.addSkills(
                                                              uploadEventProvider.skillsOptions[index],
                                                              index);
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w,
                                                        margin:
                                                        const EdgeInsets.symmetric(vertical: 5),
                                                        padding: const EdgeInsets.symmetric(
                                                            vertical: 10, horizontal: 10),
                                                        decoration: BoxDecoration(
                                                          color: uploadEventProvider.selectedIndex
                                                              .contains(index)
                                                              ? Colors.teal.shade300
                                                              : Colors.teal.shade100,
                                                          border:
                                                          Border.all(color: Colors.teal.shade900),
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Text(
                                                          uploadEventProvider.skillsOptions[index],
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ), // Add space between ListView and button
                                              Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Fluttertoast.showToast(
                                                          msg: "Skills Selected",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 2,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0
                                                      );
                                                    },
                                                    icon: const Text(
                                                      "Done",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: IconButton.styleFrom(
                                                      backgroundColor: Colors.teal,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              width: w,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey.shade600)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    uploadEventProvider.selectSkills,
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          GestureDetector(
                            onTap: ()
                            {uploadEventProvider.datePicker(context);},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              width: w,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey.shade600)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    uploadEventProvider.selectDate,
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          MyTextField(controller: uploadEventProvider.eventLandMark, hintText: "Event LandMarks"),
                          const SizedBox(height: 10,),
                          CSCPicker(
                            onCountryChanged: (value) {
                              setState(() {
                                uploadEventProvider.countryValue = value;
                              });
                            },
                            onStateChanged: (value) {
                              setState(() {
                                uploadEventProvider.stateValue = value ?? "";
                              });
                            },
                            onCityChanged: (value) {
                              setState(() {
                                uploadEventProvider.cityValue = value ?? "";
                              });
                            },
                          ),
                          const SizedBox(height: 15,),
                          MyButton(title: "Upload Event", width: 1, onclick: (){
                            if(uploadEventProvider.validate(context))
                              {
                                uploadEventProvider.uploadEvent(context);
                              }
                          },isLoading: uploadEventProvider.isLoading,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
