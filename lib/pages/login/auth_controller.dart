import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/services.dart';
import 'package:budgetium/app_config.dart';

class AuthController {
  AuthController({http.Client? client, FlutterSecureStorage? storage}) {
    if (client == null) {
      this._client = http.Client();
    } else {
      this._client = client;
    }
    if (storage == null) {
      this._storage = new FlutterSecureStorage();
    } else {
      this._storage = storage;
    }
  }
  http.Client? _client;
  FlutterSecureStorage? _storage;
  static String _userBaseURL = AppConfig.userBaseURL;
  static Future login(String username, String password) async {
    AuthController _this = new AuthController();
    var response = await _this.getToken(username, password, null);
    return response;
  }

  Future _writeToStorage(String jsonString) async {
    return await _storage!.write(key: 'key', value: json.toString());
  }

  static Future authenticate(String provider) async {
    AuthController _this = new AuthController();

    final url = '$_userBaseURL/auth/$provider/login';
    final callbackUrlScheme = 'budgetium';

    try {
      final result =
          await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);
      final code = Uri.parse(result).queryParameters['code'];

      var response = await _this.getToken(null, null, code);
      return response;
    } on PlatformException catch (e) {
      return {"statusCode": 500, "body": e};
    }
  }

  Future getToken(String? username, String? password, String? code) async {
    String clientId = AppConfig.clientId;
    String clientSecret = AppConfig.clientSecret;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    var url = Uri.parse('$_userBaseURL/oauth/token');
    Map<String, dynamic> map1;
    if (code != null) {
      map1 = {"grant_type": "authorization_code", "code": code};
    } else {
      map1 = {
        'username': username.toString(),
        'password': password.toString(),
        'scope': 'profile',
        'grant_type': 'password'
      };
    }
    var response = await this
        ._client!
        .post(url, headers: {HttpHeaders.authorizationHeader: basicAuth}, body: map1);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      await _writeToStorage(response.body);
    }
    return {"statusCode": response.statusCode, "body": jsonDecode(response.body)};
  }
}
