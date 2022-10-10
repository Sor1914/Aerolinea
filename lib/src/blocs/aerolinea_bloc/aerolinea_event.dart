//import 'dart:html';

import 'package:aerolinea/src/models/aerolinea.dart';
import 'package:equatable/equatable.dart';

class AerolineaEvent extends Equatable {
  const AerolineaEvent();
  @override
  List<Object> get props => [];
}

class Submitted extends AerolineaEvent {}

class AddRegister extends AerolineaEvent {
  final Aerolinea aerolinea;
  const AddRegister({required this.aerolinea});

  @override
  String toString() => 'AddRegisterPressed';
}

class UpdRegister extends AerolineaEvent {
  String toString() => 'ModifyRegisterPressed';
}

class DelRegister extends AerolineaEvent {
  String toString() => 'DelRegisterPressed';
}

class EmailChanged extends AerolineaEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged {email: $email}';
}
