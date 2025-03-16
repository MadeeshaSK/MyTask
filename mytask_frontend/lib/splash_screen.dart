import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/authentication/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  final String fcmToken;
  const SplashScreen({super.key, required this.fcmToken});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Timer for splash screen
  late Timer timer;
  String fcmToken = '';

  // AnimationController and Animation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initFCM();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animation duration
      vsync: this,
    );

    // Define the animation with a curve for smoothness
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth curve
    );

    // Use a Tween to animate the scale
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(curvedAnimation);

    // Start the animation
    _controller.forward();

    // Timer to navigate to the next screen
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(fcmToken: fcmToken),
        ),
      );
    });
  }

  // Initialize FCM and get token
  Future<void> _initFCM() async {
    try {
      // Request permission for notifications
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // Get FCM token
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await messaging.getToken();
        if (token != null) {
          // Store FCM token
          await _storeFCMToken(token);
          setState(() {
            fcmToken = token;
          });
          await FirebaseMessaging.instance.subscribeToTopic('all_users');
        }
      }
    } catch (e) {
      print('Error initializing FCM: $e');
    }
  }

  // Store FCM token in SharedPreferences
  Future<void> _storeFCMToken(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token);
    } catch (e) {
      print('Error storing FCM token: $e');
    }
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose(); // Dispose the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get device width and height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value, // Animate the scale
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36, // Fixed font size
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Barriecito',
                          color: AppColors.fontColorBlack,
                        ),
                      ),
                      Text(
                        'Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36, // Fixed font size
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Barriecito',
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
