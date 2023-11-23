import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos_proy/firebase_options.dart';
import 'package:topicos_proy/src/app.dart';
import 'package:topicos_proy/src/blocs/notifications_bloc/notifications_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => NotificationsBloc()),
    ],
    child: const MyApp(),
  ));
}
