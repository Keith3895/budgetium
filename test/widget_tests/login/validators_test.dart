import 'package:budgetium/pages/login/validators.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
