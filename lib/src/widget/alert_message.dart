import 'package:flutter/material.dart';


void alertMessageReceived(BuildContext context, String title ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.indigo,
      content: const Text('Alerta de robo'),
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: 'Ver',
        onPressed: () {
          // Code to execute.
        },
      ),
    ),
  );
}
