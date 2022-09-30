import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//App iniciada
class AppStarted extends AuthenticationEvent {}

//Logueado en la app
class LoggedIn extends AuthenticationEvent {}

//No logueado en la app
class LoggedOut extends AuthenticationEvent {}
