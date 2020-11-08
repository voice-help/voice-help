class PasswordValidator {
  static final Pattern _pattern =
      r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
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
