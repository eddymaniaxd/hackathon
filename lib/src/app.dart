import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos_proy/src/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:topicos_proy/src/routes/routes.dart';
import 'package:topicos_proy/src/widget/alert_message.dart';
import 'package:topicos_proy/src/widget/widgets.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
      if (state.hashCode != 0) {
        if (state.notifications.isNotEmpty) {
          alertMessageReceived(context,
              state.notifications[state.notifications.length - 1].title);
          // Widgets.alertSnackbar(context, state.notifications[state.notifications.length-1].title);
        }
      }
    }, builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), //TODO: que se maneje en base a temas
        initialRoute: Routes.initialRoute,
        routes: Routes.routes,
      );
    });
  }
}
