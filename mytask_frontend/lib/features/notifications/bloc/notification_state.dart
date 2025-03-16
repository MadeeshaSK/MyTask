part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationsFetchingState extends NotificationState {}

class NotificationsFetchedState extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationsFetchedState({required this.notifications});
}

class NotificationsErrorState extends NotificationState {
  final String error;

  NotificationsErrorState({required this.error});
}
