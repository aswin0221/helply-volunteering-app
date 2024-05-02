import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helply_app/firebase_options.dart';
import 'package:helply_app/helpers/my_local_database.dart';
import 'package:helply_app/providers/auth_providers/login_provider.dart';
import 'package:helply_app/providers/auth_providers/signup_provider.dart';
import 'package:helply_app/providers/chat_provider.dart';
import 'package:helply_app/providers/event_providers/upcoming_events_provider.dart';
import 'package:helply_app/providers/event_providers/upload_event_provider.dart';
import 'package:helply_app/providers/others/bottom_navbar_provider.dart';
import 'package:helply_app/providers/review_provider.dart';
import 'package:helply_app/providers/user_details/completed_events_provider.dart';
import 'package:helply_app/providers/user_details/my_request_providers.dart';
import 'package:helply_app/providers/user_details/my_uploads_providers.dart';
import 'package:helply_app/providers/user_details/user_detail_provider.dart';
import 'package:helply_app/providers/user_details/user_review_provider.dart';
import 'package:helply_app/providers/volunteers_provider/volunteers_provider.dart';
import 'package:helply_app/screens/Home/home_screen.dart';
import 'package:helply_app/screens/auth/login_screen.dart';
import 'package:helply_app/screens/auth/signup_screens/signup_screen.dart';
import 'package:helply_app/screens/main_screen.dart';
import 'package:helply_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) =>  runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogin = false;
  getLoginStatus()async{
    isLogin = await MyLocalStorage.getBool("isLogin") ?? false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getLoginStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context)=>SignUpProvider()),
        ChangeNotifierProvider(create: (context)=>LoginProvider()),
        ChangeNotifierProvider(create: (context)=>UploadEventProvider()),
        ChangeNotifierProvider(create: (context)=>VolunteersProvider()),
        ChangeNotifierProvider(create: (context)=>UpcomingEventProvider()),
        ChangeNotifierProvider(create: (context)=>UserDetailProvider()),
        ChangeNotifierProvider(create: (context)=>MyRequestProvider()),
        ChangeNotifierProvider(create: (context)=>CompletedEventsProvider()),
        ChangeNotifierProvider(create: (context)=>MyEventUploadProvider()),
        ChangeNotifierProvider(create: (context)=>ReviewProvider()),
        ChangeNotifierProvider(create: (context)=>UserReviewProvider()),
        ChangeNotifierProvider(create: (context)=>ChatProvider())

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        home: isLogin ? const MainScreen() : const  LoginScreen()
      ),
    );
  }
}



