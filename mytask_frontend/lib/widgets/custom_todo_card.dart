import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/home/ui/home_screen.dart';
import 'package:mytask_frontend/features/todo/bloc/to_do_bloc.dart';
import 'package:mytask_frontend/models/toDo_model.dart';

class CustomTodoCard extends StatefulWidget {
  final TodoModel todo;
  final VoidCallback viewToDoBtn;
  final VoidCallback editToDoBtn;
  final VoidCallback deleteToDoBtn;
  const CustomTodoCard({
    super.key,
    required this.todo,
    required this.viewToDoBtn,
    required this.editToDoBtn,
    required this.deleteToDoBtn,
  });

  @override
  State<CustomTodoCard> createState() => _CustomTodoCardState();
}

class _CustomTodoCardState extends State<CustomTodoCard> {
  bool? _selectedValue = false;

  final ToDoBloc _todoBloc = ToDoBloc();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.todo.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.viewToDoBtn,
      child: BlocConsumer<ToDoBloc, ToDoState>(
        bloc: _todoBloc,
        listener: (context, state) {
          if (state is ToDoEditingState) {
            isEditing = true;
          } else if (state is ToDoEditedSuccessState) {
            isEditing = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        builder: (context, state) {
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
                Checkbox(
                  value: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                    TodoModel toDoModel = TodoModel(
                      toDoID: widget.todo.toDoID,
                      toDoTitle: widget.todo.toDoTitle,
                      toDoDescription: widget.todo.toDoDescription,
                      isCompleted: _selectedValue!,
                    );
                    _todoBloc.add(ToDoEditEvent(toDoModel: toDoModel));
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppColors.accentColor;
                    }
                    return Colors.white;
                  }),
                  side: MaterialStateBorderSide.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return BorderSide(color: AppColors.accentColor);
                    }
                    return BorderSide(
                      color: AppColors.accentColor.withOpacity(1),
                    );
                  }),
                ),
                Expanded(
                  child: Text(
                    widget.todo.toDoTitle,
                    style: TextStyle(
                      color:
                          _selectedValue != null && _selectedValue == true
                              ? AppColors.fontColorBlack
                              : AppColors.accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      decoration:
                          _selectedValue != null && _selectedValue == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                      decorationThickness: widget.todo.isCompleted ? 2.5 : 1.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                // Visibility of edit and delete button
                _selectedValue != null && _selectedValue == true
                    ? SizedBox()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: widget.editToDoBtn,
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: widget.deleteToDoBtn,
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                SizedBox(width: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
