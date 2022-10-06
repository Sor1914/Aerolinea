import 'package:intl/intl.dart';

class Validators {
  static final RegExp _passRegExp = RegExp(
    r"^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{8,16}$",
  );
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp _numberRegExp = RegExp(r"/^([0-9])*$/");

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPass(String pass) {
    return _passRegExp.hasMatch(pass);
  }

  static isValidPhone(String phone) {
    if (phone.length == 8) {
      return true;
    } else {
      return false;
    }
  }

  static isValidCodeCountry(String code) {
    if (code.length == 3) {
      return true;
    } else {
      return false;
    }
  }

  static isValidPasaport(String pasaport) {
    if (pasaport.length == 13) {
      return true;
    } else {
      return false;
    }
  }

  static isValidDate(DateTime date) {
    DateTime now = DateTime.now();

    num resultadoDias = date.difference(now).inDays;
    num resultadoAnios = (resultadoDias / 365);

    if (resultadoAnios > 18) {
      return true;
    } else {
      return false;
    }
  }
}
