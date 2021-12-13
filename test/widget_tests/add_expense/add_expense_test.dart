import 'package:budgetium/pages/expense/add_expense_service.dart';
import 'package:budgetium/validators.dart';
import 'package:flutter/material.dart';
import 'package:budgetium/pages/expense/add_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'add_expense_test.mocks.dart';

Widget createWidgetForTesting({Widget? child}) {
  return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: child,
      ));
}

@GenerateMocks([FieldValidators, AddExpenseService])
void main() {
  testWidgets('when page loads all the widgets.', (WidgetTester tester) async {
    MockAddExpenseService _addExpenceService = new MockAddExpenseService();

    await tester.pumpWidget(createWidgetForTesting(
        child: Card(
      child: AddExpense(_addExpenceService),
    )));
    await tester.pumpAndSettle();
    expect(find.text('Add Expense'), findsNWidgets(1));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(7));
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
}
