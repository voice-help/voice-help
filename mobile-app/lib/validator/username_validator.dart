class UsernameValidator {
  static final Pattern _pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
  static final RegExp _regExp = RegExp(_pattern);

  static String validate(String username) {
    if(username.isEmpty){
      return 'Required';
    }
    if(username.length < 3){
      return 'Username have to be at least 3 characters';
    }
    if(!_regExp.hasMatch(username)){
      return 'Username invalid';
    }
    return null;
  }
}
