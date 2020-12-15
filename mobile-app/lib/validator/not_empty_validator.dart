class NotEmptyValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Can not be empty";
    }
    return null;
  }
}
