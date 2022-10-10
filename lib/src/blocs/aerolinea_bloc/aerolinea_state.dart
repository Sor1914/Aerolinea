import 'package:aerolinea/src/models/aerolinea.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AerolineaState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isValidEmail;

  AerolineaState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isValidEmail,
  });

  factory AerolineaState.empty() {
    return AerolineaState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isValidEmail: true);
  }

  factory AerolineaState.loading() {
    return AerolineaState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isValidEmail: true);
  }

  factory AerolineaState.failure() {
    return AerolineaState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isValidEmail: true);
  }

  factory AerolineaState.success() {
    return AerolineaState(
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isValidEmail: true);
  }

  AerolineaState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isValidEmail,
  }) {
    return AerolineaState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isValidEmail: isValidEmail ?? this.isValidEmail,
    );
  }

  AerolineaState update(
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
