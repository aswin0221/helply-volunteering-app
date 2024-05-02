import 'package:flutter/material.dart';
import 'package:helply_app/componenets/my_button.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/chat_provider.dart';
import 'package:helply_app/providers/user_details/completed_events_provider.dart';
import 'package:helply_app/providers/user_details/my_request_providers.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:helply_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

class LoginSuccessScreen extends StatefulWidget {
  const LoginSuccessScreen({super.key});

  @override
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {

  @override
  void initState() {
    // TODO: implement initState
    UserDetailProvider userDetailProvider = Provider.of(context,listen: false);
    VolunteersProvider volunteersProvider = Provider.of(context,listen: false);
    MyRequestProvider myRequestProvider = Provider.of(context,listen: false);
    CompletedEventsProvider completedEventsProvider = Provider.of(context,listen: false);
    MyEventUploadProvider myEventUploadProvider = Provider.of(context,listen: false);
    ChatProvider chatProvider = Provider.of(context,listen: false);

    // userDetailProvider.getUserDetails();
    // volunteersProvider.getAllUsers();
    // myEventUploadProvider.getMyUploads();
    // myRequestProvider.getAllRequest();
    // completedEventsProvider.getCompletedEvents();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Text("Hey,You Logged in Successfully!"),
              SizedBox(height: 10,),
              MyButton(title: "Continiue to HomePage", width: 1, onclick: (){
                MyNavigator.pushReplacementNavigator(context, const MainScreen());
              })
            ],
          ),
        ),
      ),
    );
  }
}
