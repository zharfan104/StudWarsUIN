class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^(?=.*[a-z])',
  );

  // static final RegExp _passwordRegExp = RegExp(
  //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  // );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    if (password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
}
