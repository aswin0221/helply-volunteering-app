import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/auth_providers/signup_provider.dart';
import 'package:provider/provider.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    SignUpProvider signUpProvider = Provider.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          MyTextField(
              controller: signUpProvider.aboutController, hintText: "About"),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              signUpProvider.selectedIndex = [];
              signUpProvider.mySkills = [];
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: signUpProvider.skillsOptions.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      signUpProvider.addSkills(
                                          signUpProvider.skillsOptions[index],
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
                                      color: signUpProvider.selectedIndex
                                              .contains(index)
                                          ? Colors.teal.shade300
                                          : Colors.teal.shade100,
                                      border:
                                          Border.all(color: Colors.teal.shade900),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      signUpProvider.skillsOptions[index],
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
              child: Text(
                "Select Skills",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Active Volunteer   :'),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  signUpProvider.activeVolunteer = true;
                  setState(() {});
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: signUpProvider.activeVolunteer
                            ? Colors.teal
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          color: signUpProvider.activeVolunteer
                              ? Colors.white
                              : Colors.black),
                    )),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      signUpProvider.activeVolunteer = false;
                      setState(() {});
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: !signUpProvider.activeVolunteer
                                ? Colors.teal
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: !signUpProvider.activeVolunteer
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Blood Donor           :'),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  signUpProvider.bloodDonor = true;
                  setState(() {});
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: signUpProvider.bloodDonor
                            ? Colors.teal
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Yes',
                        style: TextStyle(
                            color: signUpProvider.bloodDonor
                                ? Colors.white
                                : Colors.black))),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  signUpProvider.bloodDonor = false;
                  setState(() {});
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: !signUpProvider.bloodDonor
                            ? Colors.teal
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('No',
                        style: TextStyle(
                            color: !signUpProvider.bloodDonor
                                ? Colors.white
                                : Colors.black))),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (signUpProvider.bloodDonor)
            DropdownMenu(
                width: w * 0.9,
                onSelected: (value) {
                  signUpProvider.bloodGroup = value!;
                },
                hintText: "Select Blood Group",
                inputDecorationTheme: InputDecorationTheme(
                  constraints: const BoxConstraints(maxHeight: 50),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                menuStyle: MenuStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.white)),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "A+", label: "A+"),
                  DropdownMenuEntry(value: "A-", label: "A-"),
                  DropdownMenuEntry(value: "B+", label: "B+"),
                  DropdownMenuEntry(value: "B-", label: "B-"),
                  DropdownMenuEntry(value: "AB+", label: "AB+"),
                  DropdownMenuEntry(value: "AB-", label: "AB-"),
                  DropdownMenuEntry(value: "O+", label: "O+"),
                  DropdownMenuEntry(value: "O-", label: "O-"),
                ]),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton(
                title: "Previous",
                width: 0.4,
                onclick: () {
                  signUpProvider.changePage(0);
                },
              ),
              MyButton(
                title: "Next",
                width: 0.4,
                onclick: () {
                 if( signUpProvider.validatePageTwo(context))
                   {
                     signUpProvider.changePage(2);
                   }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
