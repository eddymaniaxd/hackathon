part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  final List<PushMessage> notifications; 
  // crear mi modelo 
  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const []
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications
  }) => NotificationsState(
    status: status ?? this.status,
    notifications: notifications ?? this.notifications
  );
  
  @override
  List<Object?> get props => [AuthorizationStatus, notifications];
}

