import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:topicos_proy/src/entities/push_message.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(
      _notificationStateChanded,
    );
    on<NotificationReceived>(_notificationReceived);
    on<TokensReceived>(_tokensReceivedAllUsers);
    //verificador de permiso
    _initialStatusCheck();

    requestPermission();
    // Listener notificaciones
    _onForegroundMessage();
  }

  void _notificationStateChanded(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(
      state.copyWith(status: event.status),
    );
    _getFCMToken();
  }

  void _notificationReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _tokensReceivedAllUsers(
      TokensReceived event, Emitter<NotificationsState> emit) {
    emit(
      state.copyWith(tokens: event.tokens),
    );
  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.notDetermined) {
      return;
    } else {
      final token = await messaging.getToken();
      print(token);
    }
  }

  void _initialStatusCheck() {
    messaging.getNotificationSettings().then((setting) {
      add(NotificationStatusChanged(setting.authorizationStatus));
    });
  }

  void _handleRemoteMessage(RemoteMessage message) {
    print('---------------------------------------------------------');
    if (message.notification == null) {
      return;
    } else {
      final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl,
      );
      add(NotificationReceived(notification));
    }
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void requestPermission() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    add(NotificationStatusChanged(settings.authorizationStatus));
  }
}
