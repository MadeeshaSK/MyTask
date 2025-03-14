import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/authentication/bloc/auth_bloc.dart';
import 'package:mytask_frontend/features/authentication/ui/login_screen.dart';
import 'package:mytask_frontend/models/user_model.dart';
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

  final AuthBloc _authBloc = AuthBloc();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is SignUpInprogressState) {
            isLoading = true;
          } else if (state is SignUpSuccessState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Sign Up Successful',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.accentColor,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is SignUpErrorState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                    child: SingleChildScrollView(
                      // to remove overflow error
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
                          isLoading
                              ? SizedBox(
                                height: 50,
                                width: screenWidth,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.accentColor,
                                    ),
                                  ),
                                ),
                              )
                              : GestureDetector(
                                onTap: () {
                                  final user = UserModel(
                                    userID: '',
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    fcmToken: '',
                                  );
                                  _authBloc.add(SignUpEvent(user: user));
                                },
                                child: CustomButton(
                                  btnWidth: screenWidth,
                                  btnText: 'Sign Up',
                                ),
                              ),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.accentColor,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
