import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytask_frontend/contants/colors.dart';
import 'package:mytask_frontend/features/notifications/bloc/notification_bloc.dart';
import 'package:mytask_frontend/models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationBloc _notificationBloc = NotificationBloc();
  bool isLoading = true;
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    _notificationBloc.add(FetchAllNotificationsEvent());
  }

  // read notifications
  Future<void> updateReadStatus(String notificationID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Notifications')
        .doc(notificationID)
        .update({'isRead': true});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 120,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.accentColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back, size: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<NotificationBloc, NotificationState>(
          bloc: _notificationBloc,
          listener: (context, state) {
            if (state is NotificationsFetchingState) {
              setState(() {
                isLoading = true;
              });
            } else if (state is NotificationsFetchedState) {
              setState(() {
                isLoading = false;
                notifications = state.notifications;
              });
            } else if (state is NotificationsErrorState) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              width: screenWidth,
              height: screenHeight - 120,
              color: Colors.white,
              child:
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentColor,
                        ),
                      )
                      : Column(
                        children: [
                          Container(
                            width: screenWidth,
                            height: 1,
                            color: AppColors.accentColor,
                          ),
                          SizedBox(
                            height: screenHeight - 121 - 60,
                            width: screenWidth,
                            child:
                                notifications.isEmpty
                                    ? const Center(
                                      child: Text(
                                        'No notifications yet',
                                        style: TextStyle(
                                          color: AppColors.fontColorBlack,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                    : ListView.builder(
                                      itemCount: notifications.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    notifications[index].title,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors
                                                              .fontColorBlack,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  content: Text(
                                                    notifications[index]
                                                        .description,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors
                                                              .fontColorBlack,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          color:
                                                              AppColors
                                                                  .accentColor,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                    ),
                                                  ],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                  ),
                                                );
                                              },
                                            );
                                            await updateReadStatus(
                                              notifications[index].id,
                                            );
                                            _notificationBloc.add(
                                              FetchAllNotificationsEvent(),
                                            );
                                          },
                                          child: Container(
                                            width: screenWidth,
                                            height: 80,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  notifications[index].isRead
                                                      ? Colors.white
                                                      : AppColors
                                                          .notificationColor,
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey.shade200,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  notifications[index].title,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors
                                                            .fontColorBlack,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  notifications[index]
                                                      .description,
                                                  style: const TextStyle(
                                                    color: AppColors.DateColor,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                          ),
                        ],
                      ),
            );
          },
        ),
      ),
    );
  }
}
