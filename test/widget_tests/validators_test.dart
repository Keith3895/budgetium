import 'package:budgetium/validators.dart';
import 'package:flutter_test/flutter_test.dart';

class testController {
  final String text = 'qwerty!234A';
}

void main() {
  testWidgets('validate Email with empty field.', (WidgetTester tester) async {
    expect(FieldValidators.validateEmail(''), 'Please enter an email id.');
  });
  testWidgets('validate Email with invalid email id.', (WidgetTester tester) async {
    expect(FieldValidators.validateEmail('invalid email id.'), 'Please enter a valid email id.');
  });
  testWidgets('validate Email with valid email id.', (WidgetTester tester) async {
    expect(FieldValidators.validateEmail('email@nal.com'), null);
  });
  testWidgets('validate Password with empty field.', (WidgetTester tester) async {
    expect(FieldValidators.validatePassword(''), 'Please enter a Password.');
  });
  testWidgets('validate Password with invalid password.', (WidgetTester tester) async {
    expect(FieldValidators.validatePassword('..'), 'Enter a valid Password');
  });
  testWidgets('validate Password with a valid password.', (WidgetTester tester) async {
    expect(FieldValidators.validatePassword('.....'), null);
  });

  testWidgets('validate Complex Password with empty field.', (WidgetTester tester) async {
    expect(FieldValidators.validateComplexPassword(''), 'Please enter a Password.');
  });
  testWidgets('validate Complex Password with a invalid password.', (WidgetTester tester) async {
    expect(FieldValidators.validateComplexPassword('.....'),
        'should contain at least one upper case,\n least one lower case, least one digit,\n least one Special character,\n Must be at least 8 characters in length');
  });
  testWidgets('validate Complex Password with a valid password.', (WidgetTester tester) async {
    expect(FieldValidators.validateComplexPassword('qwerty!234A'), null);
  });

  testWidgets('validate Confirm Password with a valid password.', (WidgetTester tester) async {
    expect(FieldValidators.validateConfirmPassword('qwerty!234A', new testController()), null);
  });
  testWidgets('validate Confirm Password with a invalid password.', (WidgetTester tester) async {
    expect(FieldValidators.validateConfirmPassword('qwerty!2', new testController()),
        'The Passwords don\'t match');
  });
  testWidgets('validate Name and mobile with empty field.', (WidgetTester tester) async {
    expect(FieldValidators.validateMobile(''), 'Please enter a Mobile Number.');
    expect(FieldValidators.validateName(''), 'Please enter a Name.');
  });
}
