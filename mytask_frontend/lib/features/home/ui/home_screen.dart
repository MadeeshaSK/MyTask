import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/todo/bloc/to_do_bloc.dart';
import 'package:mytask_frontend/features/todo/ui/add_todo.dart';
import 'package:mytask_frontend/features/todo/ui/edit_todo.dart';
import 'package:mytask_frontend/features/todo/ui/view_todo.dart';
import 'package:mytask_frontend/models/toDo_model.dart';
import 'package:mytask_frontend/models/user_model.dart';
import 'package:mytask_frontend/widgets/custom_todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ToDoBloc _toDoBloc = ToDoBloc();

  bool isLoading = true;

  List<TodoModel> toDoList = [];
  List<TodoModel> allCompletedToDos = [];
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _toDoBloc.add(ToDoShowAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Delete conformation dialog
    void deleteConfirmationDialog(String toDoId, ToDoBloc toDoBloc) {
      showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: 100,
            height: 100,
            child: AlertDialog(
              title: const Text('Delete Confirmation'),
              content: const Text('Are you sure to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () {
                    toDoBloc.add(ToDoDeleteEvent(toDoId: toDoId));
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              DateFormat('EEEE, MMM d, yyyy').format(DateTime.now()),
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
        child: BlocConsumer<ToDoBloc, ToDoState>(
          bloc: _toDoBloc,
          listener: (context, state) {
            if (state is ToDoShowingState) {
              isLoading = true;
            } else if (state is ToDoShowedSuccessState) {
              isLoading = false;
              toDoList = state.toDoList;
              allCompletedToDos = state.completedToDoList;
              userModel = state.userModel;
              setState(() {});
            } else if (state is ToDoShowedFailedState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ToDoDeletedSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task Deleted Successfully'),
                  backgroundColor: AppColors.accentColor,
                ),
              );
              _toDoBloc.add(ToDoShowAllEvent());
            } else if (state is ToDoDeletedFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              height: screenHeight - AppBar().preferredSize.height,
              width: screenWidth,
              child:
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentColor,
                        ),
                      )
                      : Column(
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
                                    'Welcome ${userModel?.name ?? 'User'}',
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
                                  SizedBox(height: 15),
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
                                    height: 65,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
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
                                          value:
                                              toDoList.isEmpty
                                                  ? 0
                                                  : (allCompletedToDos.length /
                                                          toDoList.length)
                                                      .toDouble(),
                                          color: Colors.white,
                                          backgroundColor:
                                              AppColors.ProgressBGColor,
                                        ),
                                        SizedBox(height: 5),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            toDoList.isEmpty
                                                ? '0%'
                                                : '${((allCompletedToDos.length / toDoList.length) * 100).toStringAsFixed(0)}%',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          SingleChildScrollView(
                            child: Container(
                              width: screenWidth,
                              height:
                                  screenHeight -
                                  (AppBar().preferredSize.height + 240),
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
                                  SizedBox(height: 5),
                                  SizedBox(
                                    width: screenWidth,
                                    height:
                                        screenHeight -
                                        (AppBar().preferredSize.height +
                                            250 +
                                            25),
                                    child:
                                        toDoList.isEmpty
                                            ? Center(
                                              child: Text(
                                                'No tasks available',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            )
                                            : ListView.builder(
                                              itemCount: toDoList.length,
                                              itemBuilder: (context, index) {
                                                return CustomTodoCard(
                                                  viewToDoBtn: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ViewToDoScreen(
                                                              toDoModel:
                                                                  toDoList[index],
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  deleteToDoBtn: () {
                                                    deleteConfirmationDialog(
                                                      toDoList[index].toDoID,
                                                      _toDoBloc,
                                                    );
                                                  },
                                                  editToDoBtn: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => EditToDoScreen(
                                                              toDoModel:
                                                                  toDoList[index],
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  todo: toDoList[index],
                                                );
                                              },
                                            ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accentColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddToDoScreen()),
          );
        },
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
