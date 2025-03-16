import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytask_frontend/features/authentication/ui/login_screen.dart';

class SplashScreen extends StatefulWidget {
  // fcm token
  final String fcmToken;
  const SplashScreen({super.key, required this.fcmToken});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Timer for splash screen
  late Timer timer;
  // initialize(first thing what should happen) to UI and navigate to login screen
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      // if use pushReplacement, user can't go back to splash screen
      // if use push, user can go back to splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(fcmToken: widget.fcmToken),
        ),
      );
    });
  }

  //Last thing what should happen in this screeen
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // get device width and heigth
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(child: Image.asset('assets/logo/MyTask.png')),
        ),
      ),
    );
  }
}
