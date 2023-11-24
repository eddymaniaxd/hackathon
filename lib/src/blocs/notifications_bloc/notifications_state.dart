part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  final List<PushMessage> notifications; 
  final List<String> tokens;
  // crear mi modelo 
  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
    this.tokens = const ['fQHrfm7cRuSLP2FZ-84WQ_:APA91bHAbC7-d35LdoyCW4iNnQx4EK4cTJTLjOTjLK0sbxv8TPJdB-V2XvpcWtBE2g4TvM7VOapbqnV5o2TJEr3JO3yYlGLaYtKDo9Tr-eA3TN1j1OalduH_sh3eWG5qMMq9g-BTIUP9']
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
    List<String>? tokens
  }) => NotificationsState(
    status: status ?? this.status,
    notifications: notifications ?? this.notifications,
    tokens: tokens ?? this.tokens
  );
  
  @override
  List<Object?> get props => [status, notifications, tokens];
}

