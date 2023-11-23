part of 'notifications_bloc.dart';


class NotificationsEvent {
  NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;
  NotificationStatusChanged(this.status);
}
