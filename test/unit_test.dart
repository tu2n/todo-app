import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/screens/home/input_validator.dart';




void main () {

  test('empty todo title return error string', () {
    var result = InputValidator.validate('');
    expect(result, 'Todo title can\'t be empty!');
  });

  test('non-empty todo title return error null', () {
    var result = InputValidator.validate('New Todo');
    expect(result, null);
  });
}