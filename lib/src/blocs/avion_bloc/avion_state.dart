import 'package:aerolinea/src/models/avion.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AvionState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isValidEmail;
  final bool isReserved;

  AvionState(
      {required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      required this.isValidEmail,
      required this.isReserved});

  factory AvionState.empty() {
    return AvionState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isValidEmail: true,
        isReserved: false);
  }

  factory AvionState.loading() {
    return AvionState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isValidEmail: true,
        isReserved: false);
  }

  factory AvionState.failure() {
    return AvionState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isValidEmail: true,
        isReserved: false);
  }

  factory AvionState.success() {
    return AvionState(
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isValidEmail: true,
        isReserved: false);
  }

  factory AvionState.change() {
    return AvionState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isValidEmail: false,
        isReserved: false);
  }

  AvionState copyWith(
      {bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      bool? isValidEmail,
      bool? isReserved}) {
    return AvionState(
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isReserved: isReserved ?? this.isReserved);
  }

  AvionState update(
      {bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      bool? isValidEmail,
      bool? isReserved}) {
    return copyWith(
        isFailure: isFailure,
        isSuccess: isSuccess,
        isSubmitting: isSubmitting,
        isValidEmail: isValidEmail,
        isReserved: isReserved);
  }
}
