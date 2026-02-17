import 'package:beyou/core/const/color_constants.dart';
import 'package:beyou/screens/onboarding/page/onboarding_page.dart';
import 'package:beyou/screens/tab_bar/page/tab_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Firebase disabled for demo - uncomment when configured
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Notifications disabled for demo
  }

  @override
  Widget build(BuildContext context) {
    // Bypass auth for demo - set to false to see onboarding
    final isLoggedIn = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: ColorConstants.textColor),
          bodyMedium: TextStyle(color: ColorConstants.textColor),
        ),
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedIn ? TabBarPage() : OnboardingPage(),
    );
  }
}
