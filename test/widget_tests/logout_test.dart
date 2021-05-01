import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:budgetium/pages/Logout.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('on load of page the tile and subtitle should be visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: Logout()));
    await tester.pumpAndSettle();
    expect(find.text('BUDGETIUM'), findsOneWidget);
  });
}
