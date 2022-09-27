import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aerolinea/page/MenuPrincipalVista.dart';
import 'package:aerolinea/page/Login/RegistroVista.dart';
import 'package:aerolinea/page/Login/inicioSesionVista.dart';
import 'package:aerolinea/page/Aerolinea/AgregarAvion.dart';
import 'package:aerolinea/page/Aerolinea/AgregarAerolinea.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login_screen',
      routes: {
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        'agregar_avion': (context) => AgregarAvion(),
        'agregar_aerolinea': (context) => AgregarAerolinea()
      },
    );
  }
}
