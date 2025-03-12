import 'package:flutter/material.dart';
import 'package:mytask_frontend/contants/colors.dart';

class CustomButton extends StatelessWidget {
  final double btnWidth;
  final String btnText;
  const CustomButton({
    super.key,
    required this.btnWidth,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
