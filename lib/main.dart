import 'package:bellshub/screens/home.dart';
import 'package:bellshub/screens/signup_steps/register_screen.dart';
import 'package:bellshub/screens/signup_steps/upload_id_card_step.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/signup_steps/school_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initMethod() async {
    Constants.myVerificationStatus =
        await SharedPrefrenceUtils.getUserVerifiedSharedPreference();
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => Home(),
      //   '/settings': (context) => Settings(),
      //   '/groups': (context) => Groups(),
      // },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisterScreen(),
      //(Constants.myVerificationStatus == 'Awaiting')
      //     ? Verification()
      //     : (Constants.myVerificationStatus == 'Verified')
      //         ? Home()
      //         : RegisterScreen()
    );
  }
}
