
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helply_app/componenets/my_appbar.dart';
import 'package:helply_app/componenets/my_loader.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/helpers/my_navigator.dart';
import 'package:helply_app/providers/user_details/my_request_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/screens/events/single_event_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({super.key});

  @override
  State<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  @override
  PageController pageController = PageController();
  int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    MyRequestProvider myRequestProvider = Provider.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar("My Requests"),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: whiteColor,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      onPressed: () {
                        pageController.jumpToPage(0);
                      },
                      child: Text(
                        "Pending",
                        style: TextStyle(
                            color:
                                currentPage == 0 ? primaryColor : Colors.grey,
                            fontWeight: currentPage == 0
                                ? FontWeight.bold
                                : FontWeight.w400),
                      )),
                  MaterialButton(
                      onPressed: () {
                        pageController.jumpToPage(1);
                      },
                      child: Text(
                        "Accepted",
                        style: TextStyle(
                            color:
                                currentPage == 1 ? primaryColor : Colors.grey,
                            fontWeight: currentPage == 1
                                ? FontWeight.bold
                                : FontWeight.w400),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentPage = index;
                    setState(() {});
                  },
                  children: [
                    myRequestProvider.pendingRequest.isEmpty ? const MyLoader() : ListView.builder(
                      itemCount: myRequestProvider.pendingRequest.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myRequestProvider.pendingRequest[index].eventTitle,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    myRequestProvider.pendingRequest[index].eventDescription),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${myRequestProvider.pendingRequest[index].eventCountry}, ${myRequestProvider.pendingRequest[index].eventState}\n${myRequestProvider.pendingRequest[index].eventCity}"),
                                    Text(
                                        myRequestProvider.pendingRequest[index].eventDate)
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Pending..........",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ));
                      },
                    ),
                    myRequestProvider.acceptedRequest.isEmpty ? const MyLoader() : ListView.builder(
                      itemCount: myRequestProvider.acceptedRequest.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myRequestProvider.acceptedRequest[index].eventTitle,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    myRequestProvider.acceptedRequest[index].eventDescription),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${myRequestProvider.acceptedRequest[index].eventCountry}, ${myRequestProvider.acceptedRequest[index].eventState}\n${myRequestProvider.acceptedRequest[index].eventCity}"),
                                    Text(
                                        myRequestProvider.acceptedRequest[index].eventDate)
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                    color: primaryColor,
                                    onPressed: () {
                                      MyNavigator.pushNavigator(
                                          context,
                                          SingleEventScreen(
                                            eventModel: myRequestProvider
                                                .acceptedRequest[index],
                                            intrestButton: false,
                                          ));
                                    },
                                    child: const Text(
                                      "Event Details",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
