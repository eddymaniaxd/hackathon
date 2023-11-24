import 'package:topicos_proy/src/pages/alerta/alerta_temprana.dart';
import 'package:topicos_proy/src/pages/auth/camara.dart';
import 'package:topicos_proy/src/pages/auth/login_pin.dart';
import 'package:topicos_proy/src/pages/auth/register.dart';
import 'package:topicos_proy/src/pages/auth/login.dart';
import 'package:topicos_proy/src/pages/denuncias/detalle_reclamo.dart';
import 'package:topicos_proy/src/pages/denuncias/lista_reclamos.dart';
import 'package:topicos_proy/src/pages/denuncias/nuevo_reclamos.dart';
import 'package:topicos_proy/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:topicos_proy/src/pages/mapa/googlemap.dart';
import 'package:topicos_proy/src/pages/profile_screen.dart';
import 'package:topicos_proy/src/widget/alert_dialog.dart';

class Routes {
  static const initialRoute = 'map';
  static final Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => HomePage(),
    'login': (BuildContext context) => Login(),
    'register': (BuildContext context) => const Register(),
    'camara': (BuildContext context) => const CamaraApp(),
    'reclamo': (BuildContext context) => const Reclamo(),
    'detalle_reclamo': (BuildContext context) => DetalleReclamo(),
    'map': (BuildContext context) => const MapaGoogle(),
    'login_pin': (BuildContext context) => const LoginPin(),
    'profile': (BuildContext context) => const ProfileScreen(),
    'lista_reclamos': (BuildContext context) => const ReclamoListView(),
    'alerta_temprana': (BuildContext context) => const AlertaTemprana(),
  };
  static final routesName = {
    'home': 'home',
    'login': 'login',
    'register': 'register',
    'camara': 'camara',
    'reclamo': 'reclamo',
    'detalle_reclamo': 'detalle_reclamo',
    'map': 'map',
    'login_pin': 'login_pin',
    'profile': 'profile',
    'lista_reclamos': 'lista_reclamos',
    'alerta_temprana': 'alerta_temprana'
  };
}
