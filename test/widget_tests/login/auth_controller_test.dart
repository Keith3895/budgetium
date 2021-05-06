import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';
import 'package:budgetium/pages/login/auth_controller.dart';
import 'auth_controller_test.mocks.dart';
import 'dart:convert';
import 'package:budgetium/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client, FlutterSecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('authentication', () {
    test('returns token on success, with valid username and password.', () async {
      final client = MockClient();
      String clientId = AppConfig.clientId;
      String clientSecret = AppConfig.clientSecret;
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(Uri.http('localhost:4000', '/oauth/token'),
              headers: {HttpHeaders.authorizationHeader: basicAuth},
              body: {
                'username': 'username',
                'password': 'password',
                'scope': 'profile',
                'grant_type': 'password'
              },
              encoding: null))
          .thenAnswer((_) async => http.Response(
              '{"access_token": "z6cHFUMQojkLjEHwfAcY9zoHrCmgYD9q5p0nQ5yJXa", "expires_in": 864000, "scope": "profile", "token_type": "Bearer"}',
              200));

      AuthController ac = AuthController(client: client, storage: MockFlutterSecureStorage());
      var res = await ac.getToken('username', 'password', null);
      expect(res, {
        "statusCode": 200,
        "body": jsonDecode(
            '{"access_token": "z6cHFUMQojkLjEHwfAcY9zoHrCmgYD9q5p0nQ5yJXa", "expires_in": 864000, "scope": "profile", "token_type": "Bearer"}')
      });
    });
    test('returns token on success, with valid Auth Code.', () async {
      final client = MockClient();
      String clientId = AppConfig.clientId;
      String clientSecret = AppConfig.clientSecret;
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(Uri.http('localhost:4000', '/oauth/token'),
              headers: {HttpHeaders.authorizationHeader: basicAuth},
              body: {"grant_type": "authorization_code", "code": 'code'},
              encoding: null))
          .thenAnswer((_) async => http.Response(
              '{"access_token": "z6cHFUMQojkLjEHwfAcY9zoHrCmgYD9q5p0nQ5yJXa", "expires_in": 864000, "scope": "profile", "token_type": "Bearer"}',
              200));

      AuthController ac = AuthController(client: client, storage: MockFlutterSecureStorage());
      var res = await ac.getToken(null, null, 'code');
      expect(res, {
        "statusCode": 200,
        "body": jsonDecode(
            '{"access_token": "z6cHFUMQojkLjEHwfAcY9zoHrCmgYD9q5p0nQ5yJXa", "expires_in": 864000, "scope": "profile", "token_type": "Bearer"}')
      });
    });
  });
}
