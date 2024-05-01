import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/providers/auth_providers/signup_provider.dart';
import 'package:provider/provider.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    SignUpProvider signUpProvider = Provider.of(context);
    return Column(
      children: [
        MyTextField(
            controller: signUpProvider.nameController,
            hintText: "Your Name"),
        const SizedBox(
          height: 5,
        ),
        MyTextField(
            controller: signUpProvider.mobileController,
            hintText: "Mobile Number"),
        const SizedBox(
          height: 5,
        ),
        MyTextField(
            controller: signUpProvider.emergencyMobileNumber,
            hintText: "Emergence Mobile Number"),
        const SizedBox(
          height: 15,
        ),
        CSCPicker(
          onCountryChanged: (value) {
            setState(() {
              signUpProvider.countryValue = value;
            });
          },
          onStateChanged: (value) {
            setState(() {
              signUpProvider.stateValue = value ?? "";
            });
          },
          onCityChanged: (value) {
            setState(() {
              signUpProvider.cityValue = value ?? "";
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        MyButton(
          title: "Next",
          width: 0.5,
          onclick: () {
            if(signUpProvider.validatePageOne(context))
              {
                signUpProvider.changePage(1);
              }
          },
        ),
      ],
    );
  }
}
