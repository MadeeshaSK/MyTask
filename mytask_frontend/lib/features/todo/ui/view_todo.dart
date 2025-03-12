import 'package:flutter/material.dart';
import 'package:mytask_frontend/contants/colors.dart';

class ViewToDoScreen extends StatelessWidget {
  const ViewToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        toolbarHeight: 120,
        centerTitle: true,
        title: const Text(
          'View Task',
          style: TextStyle(
            color: Colors.white,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight - 120,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Solve Calculus Worksheet',
                style: TextStyle(
                  color: AppColors.fontColorBlack,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 40),
              const Text(
                'Description',
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Complete all differentiation and integration problems in the given calculus worksheet. Verify answers using reference materials and submit by the deadline.',
                style: TextStyle(
                  color: AppColors.fontColorBlack,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
