import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/home/ui/home_screen.dart';
import 'package:mytask_frontend/features/todo/bloc/to_do_bloc.dart';
import 'package:mytask_frontend/models/toDo_model.dart';

class EditToDoScreen extends StatefulWidget {
  final TodoModel toDoModel;
  const EditToDoScreen({super.key, required this.toDoModel});

  @override
  State<EditToDoScreen> createState() => _EditToDoScreenState();
}

class _EditToDoScreenState extends State<EditToDoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ToDoBloc _toDoBloc = ToDoBloc();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.toDoModel.toDoTitle;
    _descriptionController.text = widget.toDoModel.toDoDescription;
  }

  bool isLoading = false;

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
          'Edit Task',
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ToDoBloc, ToDoState>(
          bloc: _toDoBloc,
          listener: (context, state) {
            if (state is ToDoEditingState) {
              isLoading = true;
              _titleController.clear();
              _descriptionController.clear();
            } else if (state is ToDoEditedSuccessState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task Updated Successfully'),
                  backgroundColor: AppColors.accentColor,
                ),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              });
            } else if (state is ToDoEditedFailedState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
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
              child: SingleChildScrollView(
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
                    TextField(
                      controller: _titleController,
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
                          borderSide: BorderSide(color: AppColors.accentColor),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                    TextField(
                      minLines: 5,
                      maxLines: 10,
                      controller: _descriptionController,
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
                          borderSide: BorderSide(color: AppColors.accentColor),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    SizedBox(height: 80),
                    isLoading
                        ? SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.accentColor,
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            TodoModel toDoModel = TodoModel(
                              toDoTitle: _titleController.text,
                              toDoDescription: _descriptionController.text,
                              isCompleted: widget.toDoModel.isCompleted,
                              toDoID: widget.toDoModel.toDoID,
                            );
                            _toDoBloc.add(ToDoEditEvent(toDoModel: toDoModel));
                          },
                          child: Container(
                            width: screenWidth,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Save Task',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
