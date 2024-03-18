class ValidationUtils {
  static bool isValidEmail(String email) {
    String value = email[0] + email[1] + email[2];
    if ((value == '010' || value == '012' || value == '011'|| value=='015') &&
        email.length == 11) {
      return true;
    } else {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      return emailValid;
    }
  }

  static bool isValidPhone(String email) {
    String value = email[0] + email[1] + email[2];
    if ((value == '010' || value == '012' || value == '011') &&
        email.length == 11) {
      return true;
    }
    return false;
  }
}
