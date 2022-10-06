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
    if (phone.length == 8 && _numberRegExp.hasMatch(phone)) {
      return true;
    } else {
      return false;
    }
  }

  static isValidCodeCountry(String code) {
    if (code.length == 3 && _numberRegExp.hasMatch(code)) {
      return true;
    } else {
      return false;
    }
  }

  static isValidPasaport(String pasaport) {
    if (pasaport.length == 13 && _numberRegExp.hasMatch(pasaport)) ;
  }
}
