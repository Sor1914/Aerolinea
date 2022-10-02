import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

//Cambio en el email
class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged {email: $email}';
}

//cambio en la contraseña

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
  @override
  String toString() => 'PasswordChanged {password: $password}';
}

// enviado

class Submitted extends LoginEvent {
  final String email;
  final String password;

  const Submitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() => 'Submitted {email: $password, password: $password}';
}

//login
class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() =>
      'LoginWithCredentialsPressed {email: $email, password: $password}';
}
