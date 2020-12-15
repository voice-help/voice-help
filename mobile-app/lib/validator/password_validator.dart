class PasswordValidator {
  static final Pattern _pattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,}$';
  static final RegExp _regExp = RegExp(_pattern);

  static String validate(String password) {
    if (password.isEmpty) {
      return 'Required';
    }
    if (!_regExp.hasMatch(password)) {
      return 'Invalid password';
    }
    return null;
  }
}
