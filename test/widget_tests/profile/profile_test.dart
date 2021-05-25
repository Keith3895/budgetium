import 'package:budgetium/pages/profile/profile_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:budgetium/pages/profile/profile.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import './profile_test.mocks.dart';

Widget createWidgetForTesting({Widget? child}) {
  return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: child,
      ));
}

user() {
  return {"name": 'keith', "email": 'asdf.@afm.com'};
}

@GenerateMocks([ProfileService])
void main() {
  testWidgets('starts with a loading spinner', (WidgetTester tester) async {
    MockProfileService _mockProfileService = MockProfileService();
    when(_mockProfileService.getMyData()).thenAnswer((_) async => await user());
    await tester.pumpWidget(createWidgetForTesting(child: Profile(_mockProfileService)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('show fields.', (WidgetTester tester) async {
    MockProfileService _mockProfileService = MockProfileService();
    when(_mockProfileService.getMyData()).thenAnswer((_) async => await user());
    Widget widget = createWidgetForTesting(child: Profile(_mockProfileService));
    await tester.pumpWidget(widget);
    await tester.pumpWidget(widget);
    expect(find.byType(TextFormField), findsWidgets);
  });
}
