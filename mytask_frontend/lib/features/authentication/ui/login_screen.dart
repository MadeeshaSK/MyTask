import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mytask_frontend/contants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.loginBGColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: screenWidth - 100,
                  child: Lottie.asset('assets/animations/loginAnimation.json'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: AppColors.fontColorBlack,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Welcome Back to',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.labalTextColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(width: 5),
                          const Text(
                            'My',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.fontColorBlack,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Text(
                            'Task',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TextFieldBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TextFieldBorderColor,
                            ),
                          ),
                          label: Text(
                            'Email',
                            style: TextStyle(
                              color: AppColors.labalTextColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TextFieldBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TextFieldBorderColor,
                            ),
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              color: AppColors.labalTextColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: screenWidth,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.fontColorBlack,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'SignUp',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.accentColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
