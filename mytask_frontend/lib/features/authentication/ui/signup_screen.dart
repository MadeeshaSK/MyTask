import 'package:flutter/material.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/widgets/custom_button.dart';
import 'package:mytask_frontend/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // we use expanded widget as when type in textfield it will not overlap with image(should resize)
            Expanded(
              //flex 3+2 = 5, so 2/5 of the screen will be covered by image
              flex: 2,
              child: Image.asset('assets/images/signup.png'),
            ),
            Expanded(
              flex: 3,
              // we wrapped column with a container as we have to style the column
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                  color: AppColors.signupAccentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      // const -> it will fast(nothing will change inside)
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: AppColors.fontColorBlack,
                      ),
                    ),
                    SizedBox(height: 25),
                    CustomTextfield(
                      controller: _nameController,
                      labelText: 'Name',
                      borderColor: Colors.white,
                    ),
                    SizedBox(height: 15),
                    CustomTextfield(
                      controller: _emailController,
                      labelText: 'Email',
                      borderColor: Colors.white,
                    ),
                    SizedBox(height: 15),
                    CustomTextfield(
                      controller: _passwordController,
                      labelText: 'Password',
                      borderColor: Colors.white,
                    ),
                    SizedBox(height: 25),
                    CustomButton(btnWidth: screenWidth, btnText: 'Sign Up'),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.fontColorBlack,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Login',
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
    );
  }
}
