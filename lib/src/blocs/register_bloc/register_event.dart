import 'package:equatable/equatable.dart';

import '../../models/usuario.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

//cambio en text
class EmailChanged extends RegisterEvent {
  final String dato;

  const EmailChanged({required this.dato});

  @override
  List<Object> get props => [dato];
  @override
  String toString() => 'EmailChanged {text: $dato}';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
  @override
  String toString() => 'PasswordChanged {password: $password}';
}

class PhoneChanged extends RegisterEvent {
  final String phone;

  const PhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];
  @override
  String toString() => 'phone {text: $phone}';
}

class TextChanged extends RegisterEvent {
  final String dato;

  const TextChanged({required this.dato});

  @override
  List<Object> get props => [dato];
  @override
  String toString() => 'TextChanged {text: $dato}';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  const Submitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() => 'Submitted {email: $password, password: $password}';
}

class Validate extends RegisterEvent {
  final String email;
  final String password;
  final String number;
  final String code;
  final String number2;
  final String code2;
  final String pasaport;

  const Validate(
      {required this.email,
      required this.password,
      required this.code,
      required this.code2,
      required this.number,
      required this.number2,
      required this.pasaport});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() => 'Submitted {email: $password, password: $password}';
}

class Register extends RegisterEvent {
  final String email;
  final String password;
  final Usuario usuario;
  const Register(
      {required this.email, required this.password, required this.usuario});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() => 'Submitted {email: $password, password: $password}';
}
