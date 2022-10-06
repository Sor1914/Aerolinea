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
  final bool isRecord;
  final bool isPasaportValid;
  final bool isValidDateBirth;
  bool get isFormvalid => isEmailValid && isPasswordValid;

  RegisterState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isNumberValid,
      required this.isCodeValid,
      required this.isNumber2Valid,
      required this.isCode2Valid,
      required this.isSubmittin,
      required this.isSuccess,
      required this.isFailure,
      required this.isRecord,
      required this.isValidate,
      required this.isPasaportValid,
      required this.isValidDateBirth});

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: false,
      isPasswordValid: false,
      isNumberValid: false,
      isCodeValid: false,
      isNumber2Valid: false,
      isCode2Valid: false,
      isPasaportValid: false,
      isValidDateBirth: false,
      isSubmittin: false,
      isSuccess: false,
      isFailure: false,
      isValidate: false,
      isRecord: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isPasaportValid: true,
        isSubmittin: true,
        isValidDateBirth: true,
        isSuccess: false,
        isFailure: false,
        isValidate: false,
        isRecord: false);
  }

  factory RegisterState.failure() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isPasaportValid: true,
        isValidDateBirth: true,
        isSubmittin: false,
        isSuccess: false,
        isFailure: true,
        isRecord: false,
        isValidate: false);
  }

  factory RegisterState.success() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isPasaportValid: true,
        isCode2Valid: true,
        isValidDateBirth: true,
        isSubmittin: false,
        isSuccess: true,
        isRecord: false,
        isFailure: false,
        isValidate: true);
  }

  factory RegisterState.validated() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isValidDateBirth: true,
        isSubmittin: false,
        isPasaportValid: true,
        isSuccess: false,
        isFailure: false,
        isRecord: false,
        isValidate: true);
  }

  factory RegisterState.recorded() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isNumberValid: true,
        isCodeValid: true,
        isNumber2Valid: true,
        isCode2Valid: true,
        isValidDateBirth: true,
        isSubmittin: false,
        isPasaportValid: true,
        isSuccess: true,
        isFailure: false,
        isRecord: true,
        isValidate: true);
  }

  RegisterState copyWith(
      {bool? isEmailValid,
      bool? isPasswordValid,
      bool? isNumberValid,
      bool? isCodeValid,
      bool? isNumber2Valid,
      bool? isCode2Valid,
      bool? isSubmittin,
      bool? isSuccess,
      bool? isFailure,
      bool? isValidate,
      bool? isRecord,
      bool? isPasaportValid,
      bool? isValidDateBirth}) {
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
        isRecord: isRecord ?? this.isRecord,
        isPasaportValid: isPasaportValid ?? this.isPasaportValid,
        isValidDateBirth: isValidDateBirth ?? this.isValidDateBirth);
  }

  RegisterState update(
      {bool? isEmailValid,
      bool? isPasswordValid,
      bool? isNumberValid,
      bool? isCodeValid,
      bool? isNumber2Valid,
      bool? isCode2Valid,
      bool? isSubmittin,
      bool? isSuccess,
      bool? isFailure,
      bool? isValidate,
      bool? isRecord,
      bool? isPasaportValid,
      bool? isValidDateBirth}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isNumberValid: isNumberValid,
      isCodeValid: isCodeValid,
      isNumber2Valid: isNumber2Valid,
      isCode2Valid: isCode2Valid,
      isValidate: isValidate,
      isPasaportValid: isPasaportValid,
      isValidDateBirth: isValidDateBirth,
      isSubmittin: false,
      isSuccess: false,
      isFailure: false,
      isRecord: false,
    );
  }

  @override
  String toString() {
    return ''' RegisterState{
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmittin,
      isSuccess: $isSuccess,
      isFailure: $isFailure} ''';
  }
}
