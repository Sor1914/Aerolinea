//import 'dart:html';

import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//No inicialiado

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'No inicializado';
}
//Autenticado

class Authenticated extends AuthenticationState {
  final String displayName;

  const Authenticated(this.displayName);
  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Autenticado - displayName :$displayName';
}
//No autenticado

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'No autenticado';
}
