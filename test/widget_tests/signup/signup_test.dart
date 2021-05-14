import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:budgetium/pages/signup/signup.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:budgetium/app_config.dart';
import './signup_test.mocks.dart';

Widget createWidgetForTesting({Widget? child}) {
  return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: child,
      ));
}

@GenerateMocks([http.Client])
void main() {
  group('testing signup fields', () {
    testWidgets('check if all widgets loaded', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(
        child: SignUp(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Sign Up'), findsNWidgets(2));
      expect(find.byKey(Key('name')), findsOneWidget);
      expect(find.byKey(Key('email')), findsOneWidget);
      expect(find.byKey(Key('mobile')), findsOneWidget);
      expect(find.byKey(Key('password')), findsOneWidget);
      expect(find.byKey(Key('cPassword')), findsOneWidget);
    });
  });
  group('testing signup fields', () {
    test("call signup api method", () async {
      final client = MockClient();
      when(client.post(Uri.http('localhost:4000', '/oauth/register'),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'},
              body: utf8.encode(json.encode({
                'email': '_email',
                'full_name': '_name',
                'first_name': '_name',
                'last_name': '_name',
                'password': '_password'
              })),
              encoding: null))
          .thenAnswer((_) async => http.Response('{"user":"_email"}', 201));

      var res = await signup({
        'email': '_email',
        'full_name': '_name',
        'first_name': '_name',
        'last_name': '_name',
        'password': '_password'
      }, client);
      expect(res, {"statusCode": 201, "body": jsonDecode('{"user":"_email"}')});
    });
  });
}
