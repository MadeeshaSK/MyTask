import 'package:flutter/material.dart';
import 'package:mytask_frontend/contants/colors.dart';

class CustomTodoCard extends StatefulWidget {
  final String cardTitle;
  final bool isCompleted;
  const CustomTodoCard({
    super.key,
    required this.cardTitle,
    required this.isCompleted,
  });

  @override
  State<CustomTodoCard> createState() => _CustomTodoCardState();
}

class _CustomTodoCardState extends State<CustomTodoCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 70,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Radio(
            value: widget.isCompleted ? 0 : 1,
            groupValue: 0,
            onChanged: (value) {},
            fillColor: MaterialStateProperty.resolveWith<Color>((
              Set<MaterialState> states,
            ) {
              return AppColors.accentColor;
            }),
          ),
          Text(
            widget.cardTitle,
            style: TextStyle(
              color:
                  widget.isCompleted
                      ? AppColors.fontColorBlack
                      : AppColors.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              decoration:
                  widget.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
              decorationThickness: widget.isCompleted ? 2.5 : 1.0,
            ),
          ),
          Spacer(),
          // Visibility of edit and delete button
          widget.isCompleted
              ? SizedBox()
              : Column(
                children: [
                  Spacer(),
                  Icon(Icons.edit),
                  SizedBox(height: 5),
                  Icon(Icons.delete, color: Colors.red),
                  Spacer(),
                ],
              ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
