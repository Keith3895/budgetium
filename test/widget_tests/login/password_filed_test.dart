import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:budgetium/pages/login/password_field.dart';

void main() {
  testWidgets('Passes Field Key to underlying textFormField', (WidgetTester tester) async {
    final key = GlobalKey();
    await tester.pumpWidget(MaterialApp(
        home: Material(
      child: PasswordField(fieldKey: key),
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(key), findsOneWidget);
  });
  testWidgets('Passes hintText to underlying textFormField', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child: PasswordField(
      hintText: 'hint text',
    ))));
    await tester.pumpAndSettle();
    final Finder hintTextFinder = find.text('hint text');
    expect(hintTextFinder, findsOneWidget);
  });
  testWidgets('Passes labelText to underlying textFormField', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child: PasswordField(
      labelText: 'label Text',
    ))));
    await tester.pumpAndSettle();
    final Finder labelTextFinder = find.text('label Text');
    expect(labelTextFinder, findsOneWidget);
  });
  testWidgets('onSaved callback is called.', (WidgetTester tester) async {
    bool _called = false;
    final key = GlobalKey<FormState>();
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child: Form(
                key: key,
                child: PasswordField(
                  labelText: 'label Text',
                  onSaved: (String? value) {
                    _called = true;
                  },
                )))));
    await tester.showKeyboard(find.byType(TextField));
    await tester.testTextInput.receiveAction(TextInputAction.done);
    key.currentState!.save();
    await tester.pump();
    expect(_called, true);
  });
  testWidgets('validate is called if widget is enabled', (WidgetTester tester) async {
    int _validateCalled = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Center(
            child: PasswordField(
              validator: (String? value) {
                _validateCalled += 1;
                return null;
              },
            ),
          ),
        ),
      ),
    );

    expect(_validateCalled, 1);
    await tester.enterText(find.byType(TextField), 'a');
    await tester.pump();
    expect(_validateCalled, 2);
  });

  testWidgets('obscure text is unreadable', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Center(
            child: PasswordField(
              labelText: 'test',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    Finder icon = find.byIcon(Icons.visibility);
    expect(find.byIcon(Icons.visibility_off), findsNothing);
    expect(icon, findsOneWidget);
    await tester.tap(icon);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.visibility), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });
}
