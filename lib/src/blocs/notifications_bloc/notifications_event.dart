part of 'notifications_bloc.dart';


class NotificationsEvent {
  NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;
  NotificationStatusChanged(this.status);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage pushMessage;
  NotificationReceived(this.pushMessage);
}

class TokensReceived extends NotificationsEvent {
  final List<String> tokens;
  TokensReceived(this.tokens);
}
