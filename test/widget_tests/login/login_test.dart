import 'package:budgetium/validators.dart';
import 'package:flutter/material.dart';
import 'package:budgetium/pages/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'auth_controller_test.mocks.dart';

Widget createWidgetForTesting({Widget? child}) {
  return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: child,
      ));
}

@GenerateMocks([FieldValidators])
void main() {
  testWidgets('when page loads locate all the widgets.', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: Login()));
    await tester.pumpAndSettle();
    expect(find.text('Log In'), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(3 + 1));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets('empty email and password field should show error messages.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: Login()));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Please enter an email id.'), findsOneWidget);
    expect(find.text('Please enter a Password.'), findsOneWidget);
  });
  testWidgets('valid email and password field should not show snackbar.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: Login()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('email')), 'test@tar.com');
    await tester.pump();
    await tester.enterText(find.byKey(Key('password')), 'password');
    await tester.pump();
    // await tester.tap(find.byType(ElevatedButton));
    // await tester.pump();
    // expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please enter a Password.'), findsNothing);
  });
}
