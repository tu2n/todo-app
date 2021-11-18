class InputValidator {
  static String validate(String value) {

    return value.isEmpty ? 'Todo title can\'t be empty!' : null;
  }
}