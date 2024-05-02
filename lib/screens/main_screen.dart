import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helply_app/constants/colors.dart';
import 'package:helply_app/providers/chat_provider.dart';
import 'package:helply_app/providers/user_details/completed_events_provider.dart';
import 'package:helply_app/providers/user_details/my_request_providers.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:helply_app/screens/Home/home_screen.dart';
import 'package:helply_app/screens/events/upcoming_events_screen.dart';
import 'package:helply_app/screens/events/upload_event_screen.dart';
import 'package:helply_app/screens/profile/profile_screen.dart';
import 'package:helply_app/screens/volunteer/active_volunteer_screen.dart';
import 'package:provider/provider.dart';
import '../packages/navbar_package.dart';
import '../providers/others/bottom_navbar_provider.dart';
import 'package:line_icons/line_icons.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  int _currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const UpcomingEventsScreen(),
    const UploadEventScreen(),
    const ActiveVolunteerScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    UserDetailProvider userDetailProvider = Provider.of(context,listen: false);
    VolunteersProvider volunteersProvider = Provider.of(context,listen: false);
    MyRequestProvider myRequestProvider = Provider.of(context,listen: false);
    CompletedEventsProvider completedEventsProvider = Provider.of(context,listen: false);
    MyEventUploadProvider myEventUploadProvider = Provider.of(context,listen: false);
    ChatProvider chatProvider = Provider.of(context,listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BottomNavBarProvider bottomNavBarProvider = Provider.of(context);
    return Scaffold(
      body: screens[bottomNavBarProvider.currentIndex],
        bottomNavigationBar:  Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Container(
            height: 80,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
               type: BottomNavigationBarType.fixed ,
               useLegacyColorScheme:false,
               mouseCursor:MouseCursor.defer ,
               elevation: 80,
               selectedItemColor: Colors.teal,
               unselectedItemColor: Colors.black,
               currentIndex: _currentIndex,
               onTap: (i) => setState(() {
                 _currentIndex = i;
                 bottomNavBarProvider.index = i;
               }
               ),
               items:const [
                 /// Home
                 BottomNavigationBarItem(
                   icon: Icon(LineIcons.home),
                   label: "",
                 ),

                 /// Likes
                 BottomNavigationBarItem(
                   icon: Icon(Icons.event_available_outlined),
                   label: "",
                 ),

                 /// Search
                 BottomNavigationBarItem(
                   icon: Icon(Icons.ios_share),
                   label: "",
                 ),

                 /// Profile
                 BottomNavigationBarItem(
                   icon:  Icon(Icons.volunteer_activism),
                   label: "",
                 ),

                 ///
                 BottomNavigationBarItem(
                   icon:  Icon(Icons.person),
                   label: "",
                 )
               ],
             ),
          ),
        )
    );
  }
}
