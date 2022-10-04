import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNumberValid;
  final bool isCodeValid;
  final bool isNumber2Valid;
  final bool isCode2Valid;
  final bool isSubmittin;
  final bool isSuccess;
  final bool isFailure;
  final bool isValidate;

  bool get isFormvalid => isEmailValid && isPasswordValid;

  RegisterState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isNumberValid,
    required this.isCodeValid,
    required this.isNumber2Valid,
    required this.isCode2Valid,
    required this.isSubmittin,
    required this.isSuccess,
    required this.isFailure,
    required this.isValidate,
  });

  factory RegisterState.empty() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isSubmittin: false,
        isSuccess: false,
        isFailure: false,
        isValidate: false);
  }

  factory RegisterState.loading() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isSubmittin: true,
        isSuccess: false,
        isFailure: false,
        isValidate: false);
  }

  factory RegisterState.failure() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isSubmittin: false,
        isSuccess: false,
        isFailure: true,
        isValidate: false);
  }

  factory RegisterState.success() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isSubmittin: false,
        isSuccess: true,
        isFailure: false,
        isValidate: false);
  }

  factory RegisterState.validated() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isSubmittin: false,
        isSuccess: false,
        isFailure: false,
        isValidate: true);
  }

  RegisterState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isNumberValid,
    bool? isCodeValid,
    bool? isNumber2Valid,
    bool? isCode2Valid,
    bool? isSubmittin,
    bool? isSuccess,
    bool? isFailure,
    bool? isValidate,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isNumberValid: isNumberValid ?? this.isNumberValid,
      isCodeValid: isCodeValid ?? this.isCodeValid,
      isNumber2Valid: isNumber2Valid ?? this.isNumber2Valid,
      isCode2Valid: isCode2Valid ?? this.isCode2Valid,
      isSubmittin: isSubmittin ?? this.isSubmittin,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isValidate: isValidate ?? this.isValidate,
    );
  }

  RegisterState update({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isNumberValid,
    bool? isCodeValid,
    bool? isNumber2Valid,
    bool? isCode2Valid,
    bool? isSubmittin,
    bool? isSuccess,
    bool? isFailure,
    bool? isValidate,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isNumberValid: isNumberValid,
      isCodeValid: isCodeValid,
      isNumber2Valid: isNumber2Valid,
      isCode2Valid: isCode2Valid,
      isSubmittin: false,
      isSuccess: false,
      isFailure: false,
      isValidate: false,
    );
  }
}
