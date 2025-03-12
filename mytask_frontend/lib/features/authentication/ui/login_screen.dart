import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/widgets/custom_button.dart';
import 'package:mytask_frontend/widgets/custom_textfield.dart';

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
                      CustomTextfield(
                        controller: _emailController,
                        labelText: 'Email',
                        borderColor: AppColors.TextFieldBorderColor,
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        controller: _passwordController,
                        labelText: 'Password',
                        borderColor: AppColors.TextFieldBorderColor,
                      ),
                      SizedBox(height: 25),
                      CustomButton(btnWidth: screenWidth, btnText: 'Login'),
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
