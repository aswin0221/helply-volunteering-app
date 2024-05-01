import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/componenets/my_text_field.dart';
import 'package:helply_app/providers/auth_providers/signup_provider.dart';
import 'package:provider/provider.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  Widget build(BuildContext context) {
    SignUpProvider signUpProvider = Provider.of(context);
    return Column(
      children: [
        if(signUpProvider.profilePicture !=null)
          GestureDetector(
            onTap: (){
              signUpProvider.pickImage();
            },
            child: Container(
                width: MediaQuery.of(context).size.width*0.3,
                height: MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(signUpProvider.profilePicture!,fit:BoxFit.fitWidth,))),
          ),
        if(signUpProvider.profilePicture==null)
          GestureDetector(
            onTap: (){
              signUpProvider.pickImage();
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Icon(Icons.add_photo_alternate_sharp,color: Colors.white,size: 34,) ,
            ),
          ),
        const SizedBox(
          height: 15,
        ),
        MyTextField(
            controller: signUpProvider.emailController,
            hintText: "Email"),
        const SizedBox(
          height: 5,
        ),
        MyTextField(
            controller: signUpProvider.passwordController,
            hintText: "Password"),
        const SizedBox(
          height: 15,
        ),
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
                signUpProvider.changePage(1);
              },
            ),
            MyButton(
              title: "Sign Up",
              width: 0.4,
              isLoading: signUpProvider.isLoading,
              onclick: () {
                if(signUpProvider.validatePageThree(context))
                  {
                    signUpProvider.createAccount(context);
                  }
              },
            ),
          ],
        ),
      ],
    );
  }
}
