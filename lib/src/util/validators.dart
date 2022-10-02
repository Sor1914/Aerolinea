class Validators {
  static final RegExp _passRegExp = RegExp(
    r"^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{8,16}$",
  );
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPass(String pass) {
    return _passRegExp.hasMatch(pass);
  }
}
