import 'package:flutter/material.dart';
import 'package:mytask_frontend/contants/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 120,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.accentColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.arrow_back, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight - 120,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: 1,
                color: AppColors.accentColor,
              ),
              Container(
                width: screenWidth,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Task Completed',
                      style: TextStyle(
                        color: AppColors.fontColorBlack,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Well done Madeesha, you have completed the task "Solve Calculus Worksheet"',
                      style: TextStyle(
                        color: AppColors.DateColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
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
