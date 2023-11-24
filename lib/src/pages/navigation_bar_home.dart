import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos_proy/src/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:topicos_proy/src/pages/alertas/alertas_pages.dart';
import 'package:topicos_proy/src/pages/alertas/historial_pages.dart';
import 'package:topicos_proy/src/pages/mapa/googlemap.dart';
import 'package:topicos_proy/src/widget/alert_message.dart';
import 'package:topicos_proy/src/widget/widgets.dart';

class NavigationBarHome extends StatelessWidget {
  const NavigationBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavigationAlerta();
  }
}

class NavigationAlerta extends StatefulWidget {
  const NavigationAlerta({super.key});

  @override
  State<NavigationAlerta> createState() => _NavigationAlertaState();
}

class _NavigationAlertaState extends State<NavigationAlerta> {
  int currentPageIndex = 0;
  @override
  void initState() {
    // final notificationBloc = context.read<NotificationsBloc>();
    // notificationBloc.requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
      if (state.hashCode != 0 && state.notifications.isNotEmpty) {
        var message = state.notifications[state.notifications.length-1].title;
        alertMessageReceived(context, message);
        //Widgets.alertSnackbar(context," mesage");
      }
    }, builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.blue,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.crisis_alert_sharp),
              icon: Icon(Icons.crisis_alert_sharp),
              label: 'Alertas',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notificationes',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.history),
              ),
              label: 'Historial',
            ),
          ],
        ),
        body: <Widget>[
          const MapaGoogle(),
          AlertasPage(),
          const HistorialPage()
        ][currentPageIndex],
      );
    });
  }
}
