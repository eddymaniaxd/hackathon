import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:topicos_proy/src/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:topicos_proy/src/pages/auth/login.dart';
import 'package:topicos_proy/src/pages/mapa/googlemap.dart';

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
  Widget build(BuildContext context) {
    final notificationBloc = context.watch<NotificationsBloc>();
    notificationBloc.requestPermission();
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
        const Text('segundo'),
        const Text('tercero'),
      ][currentPageIndex],
    );
  }
}
