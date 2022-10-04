import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

//cambio en text
class FieldChanged extends RegisterEvent {
  final String field;

  const FieldChanged({required this.field});

  String toString() => 'FieldChanged {text: $field}';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  const Submitted({required this.email, required this.password});

  String toString() => 'Submitted {email: $password, password: $password}';
}

class Validated extends RegisterEvent {
  final String email;
  final String password;

  const Validated({required this.email, required this.password});

  String toString() => 'Submitted {email: $password, password: $password}';
}

class Register extends RegisterEvent {
  final String email;
  final String password;

  const Register({required this.email, required this.password});

  String toString() => 'Submitted {email: $password, password: $password}';
}
