//import 'dart:html';

import 'package:aerolinea/src/models/avion.dart';
import 'package:equatable/equatable.dart';

class AvionEvent extends Equatable {
  const AvionEvent();
  @override
  List<Object> get props => [];
}

class Submitted extends AvionEvent {}

class AddRegister extends AvionEvent {
  final Avion avion;
  const AddRegister({required this.avion});

  @override
  String toString() => 'AddRegisterPressed';
}

class UpdRegister extends AvionEvent {
  String toString() => 'ModifyRegisterPressed';
}

class DelRegister extends AvionEvent {
  String toString() => 'DelRegisterPressed';
}

class EmailChanged extends AvionEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged {email: $email}';
}
