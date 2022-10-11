import 'package:aerolinea/src/models/avion.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AvionState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isValidEmail;

  AvionState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isValidEmail,
  });

  factory AvionState.empty() {
    return AvionState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isValidEmail: true);
  }

  factory AvionState.loading() {
    return AvionState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isValidEmail: true);
  }

  factory AvionState.failure() {
    return AvionState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isValidEmail: true);
  }

  factory AvionState.success() {
    return AvionState(
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isValidEmail: true);
  }

  AvionState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isValidEmail,
  }) {
    return AvionState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isValidEmail: isValidEmail ?? this.isValidEmail,
    );
  }

  AvionState update(
      {bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      bool? isValidEmail}) {
    return copyWith(
        isFailure: isFailure,
        isSuccess: isSuccess,
        isSubmitting: isSubmitting,
        isValidEmail: isValidEmail);
  }
}
