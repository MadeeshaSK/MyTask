import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mytask_frontend/models/notification_model.dart';
import 'package:mytask_frontend/services/notifications-services.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationServices notificationServices = NotificationServices();
  NotificationBloc() : super(NotificationInitial()) {
    on<FetchAllNotificationsEvent>(fletchAllNotificationsEvent);
  }

  FutureOr<void> fletchAllNotificationsEvent(
    FetchAllNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      emit(NotificationsFetchingState());
      await notificationServices.getAllNotifications();
      emit(
        NotificationsFetchedState(
          notifications: notificationServices.notifications,
        ),
      );
    } catch (e) {
      emit(NotificationsErrorState(error: e.toString()));
    }
  }
}
