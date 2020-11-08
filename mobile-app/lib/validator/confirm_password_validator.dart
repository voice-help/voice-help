class ConfirmPasswordValidator {
  static String validate(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return 'Required';
    }
    if (confirmPassword != password) {
      return 'Passwords are not equal';
    }
    return null;
  }
}
