import 'package:budgetium/pages/profile/profile_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:budgetium/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import './profile_service_test.mocks.dart';

user() {
  return {"name": 'keith', "email": 'asdf.@afm.com'};
}

@GenerateMocks([FlutterSecureStorage, GraphQLClient])
//customMocks: [MockSpec<GraphQLClient>(returnNullOnMissingStub: true)])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('check if correct client is returned', () async {
    ProfileService profileService = new ProfileService(testingFlag: true);
    MockGraphQLClient _client = new MockGraphQLClient();
    var expectedClient = profileService.createBudgetiumClient('token', client: _client);
    expect(_client, expectedClient);
  });
  test('call getToken to get valid result', () async {
    ProfileService profileService = new ProfileService(testingFlag: true);
    String _token =
        '{"access_token": "jFVF82AMiSMppei13Fp9mRgEvTGzuNXav7pWqu55bB", "expires_in": 864000, "scope": "profile", "token_type": "Bearer"}';
    MockFlutterSecureStorage _storage = new MockFlutterSecureStorage();
    when(_storage.read(key: 'key')).thenAnswer((realInvocation) async {
      return _token;
    });
    var result = await profileService.getCurrentToken(storage: _storage);
    expect(result, 'Bearer jFVF82AMiSMppei13Fp9mRgEvTGzuNXav7pWqu55bB');
  });
}
