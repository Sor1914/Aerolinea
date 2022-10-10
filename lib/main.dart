import 'package:aerolinea/src/ui/register/register_screen.dart';
import 'package:aerolinea/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aerolinea/src/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:aerolinea/src/blocs/authentication%20bloc/authentication_event.dart';
import 'package:aerolinea/src/blocs/authentication%20bloc/authentication_state.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:aerolinea/src/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aerolinea/src/ui/home_screen.dart';
import 'package:aerolinea/src/ui/AgregarAvion.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aerolinea/src/blocs/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();
  UserRepository userRepository = UserRepository();

  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Authenticated) {
            return HomeScreen(
              userRepository: _userRepository,
            );
          }
          if (state is Unauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          return Container();
          //return LoginScreen();
        },
      ),
    );
  }
}
