import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/home/ui/home_screen.dart';
import 'package:mytask_frontend/features/todo/bloc/to_do_bloc.dart';
import 'package:mytask_frontend/models/toDo_model.dart';
import 'package:mytask_frontend/widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late ToDoBloc _toDoBloc;

  bool isLoading = false;
  String toDoUniqueID = '';

  @override
  void initState() {
    super.initState();
    toDoUniqueID = Uuid().v4();
    _toDoBloc = ToDoBloc();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
          'Add Task',
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
                Navigator.pop(
                  context,
                ); // Navigate back when the button is pressed
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
            if (state is ToDoAddingState) {
              isLoading = true;
            } else if (state is ToDoAddedSucessState) {
              isLoading = false;
              _titleController.clear();
              _descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task Added Successfully'),
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
            } else if (state is ToDoAddedFailedState) {
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
                    SizedBox(height: 10),
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
                        hintText: 'Ex: Solve Calculus Worksheet',
                        hintStyle: TextStyle(
                          color: AppColors.labalTextColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
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
                    SizedBox(height: 10),
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
                        hintText:
                            'Ex: Complete all differentiation and integration problems in the given calculus worksheet. Verify answers using reference materials and submit by the deadline.',
                        hintStyle: TextStyle(
                          color: AppColors.labalTextColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    SizedBox(height: 80),
                    isLoading
                        ? SizedBox(
                          width: screenWidth,
                          height: 50,
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
                            if (_titleController.text.isEmpty ||
                                _descriptionController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill all the fields'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            } else {
                              TodoModel toDoModel = TodoModel(
                                toDoID: toDoUniqueID,
                                toDoTitle: _titleController.text,
                                toDoDescription: _descriptionController.text,
                                isCompleted: false,
                              );
                              _toDoBloc.add(ToDoAddEvent(toDoModel: toDoModel));
                            }
                          },
                          child: CustomButton(
                            btnWidth: screenWidth,
                            btnText: 'Create Task',
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
