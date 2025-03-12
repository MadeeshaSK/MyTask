import 'package:flutter/material.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/widgets/custom_todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Tuesday, Mar 11 2025',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/notification-icon.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: screenHeight - AppBar().preferredSize.height,
          width: screenWidth,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: screenWidth,
                  height: 240,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Welcome Madeesha',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Text(
                        'Have a nice day!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Spacer(),
                      SizedBox(height: 20),
                      const Text(
                        'Today Progress',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: screenWidth,
                        height: 70,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/home-background.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            const Text(
                              'Progress',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            LinearProgressIndicator(
                              value: 0.8,
                              color: Colors.white,
                              backgroundColor: AppColors.ProgressBGColor,
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '80%',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight - (AppBar().preferredSize.height + 240),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: const Text(
                        'Daily Tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      height:
                          screenHeight -
                          (AppBar().preferredSize.height + 240 + 25),
                      child: Column(
                        children: [
                          CustomTodoCard(
                            cardTitle: 'Work Out',
                            isCompleted: false,
                          ),
                          CustomTodoCard(
                            cardTitle: 'Meeting',
                            isCompleted: true,
                          ),
                          CustomTodoCard(
                            cardTitle: 'Shopping',
                            isCompleted: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accentColor,
        onPressed: () {},
        label: Row(
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
