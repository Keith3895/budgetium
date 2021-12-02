// Mocks generated by Mockito 5.0.16 from annotations
// in budgetium/test/widget_tests/profile/profile_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:budgetium/pages/profile/profile_service.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:graphql/client.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGraphQLClient_0 extends _i1.Fake implements _i2.GraphQLClient {}

/// A class which mocks [ProfileService].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileService extends _i1.Mock implements _i3.ProfileService {
  MockProfileService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get testingFlag =>
      (super.noSuchMethod(Invocation.getter(#testingFlag), returnValue: false)
          as bool);
  @override
  set testingFlag(bool? _testingFlag) =>
      super.noSuchMethod(Invocation.setter(#testingFlag, _testingFlag),
          returnValueForMissingStub: null);
  @override
  _i2.GraphQLClient createBudgetiumClient(String? token,
          {_i2.GraphQLClient? client}) =>
      (super.noSuchMethod(
          Invocation.method(#createBudgetiumClient, [token], {#client: client}),
          returnValue: _FakeGraphQLClient_0()) as _i2.GraphQLClient);
  @override
  _i4.Future<dynamic> getMyData(
          {_i2.GraphQLClient? client, _i5.FlutterSecureStorage? storage}) =>
      (super.noSuchMethod(
          Invocation.method(
              #getMyData, [], {#client: client, #storage: storage}),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> getCurrentToken({_i5.FlutterSecureStorage? storage}) =>
      (super.noSuchMethod(
          Invocation.method(#getCurrentToken, [], {#storage: storage}),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  String toString() => super.toString();
}
