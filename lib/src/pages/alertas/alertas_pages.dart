import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos_proy/src/blocs/notifications_bloc/notifications_bloc.dart';

class AlertasPage extends StatelessWidget {
  const AlertasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationsBloc>().state.notifications;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones:'),
      ),
      body: Container(
        padding: const EdgeInsetsDirectional.all(20),
        child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (_, index) => Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(notifications[index].title),
                      subtitle: Text(notifications[index].body),
                      leading: const Icon(Icons.notification_add),
                      trailing: IconButton(
                        onPressed: () {
                          print("ver más");
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide( width: 2 ),
                        borderRadius: BorderRadius.circular(20)
                      ),

                    ),
                  ),
                )),
      ),
    );
  }
}
