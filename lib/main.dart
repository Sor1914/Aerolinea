import 'package:aerolinea/src/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:aerolinea/src/blocs/authentication%20bloc/authentication_event.dart';
import 'package:aerolinea/src/blocs/authentication%20bloc/authentication_state.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aerolinea/src/ui/MenuPrincipalVista.dart';
import 'package:aerolinea/src/ui/RegistroVista.dart';
import 'package:aerolinea/src/ui/inicioSesion.dart';
import 'package:aerolinea/src/ui/AgregarAvion.dart';
import 'package:aerolinea/src/ui/AgregarAerolinea.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
