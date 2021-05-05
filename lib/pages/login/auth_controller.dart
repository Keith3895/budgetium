import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/services.dart';
import 'package:budgetium/app_config.dart';

class AuthController {
  final storage = new FlutterSecureStorage();
  static String _userBaseURL = AppConfig.userBaseURL;
  static Future login(String username, String password) async {
    AuthController _this = new AuthController();
    var response = await _this.getToken(username, password, null);
    return response;
  }

  void _writeToStorage(String jsonString) async {
    await storage.write(key: 'key', value: json.toString());
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
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({HttpHeaders.authorizationHeader: basicAuth});

    if (code != null) {
      request
        ..fields['grant_type'] = 'authorization_code'
        ..fields['code'] = code;
    } else {
      request
        ..fields['username'] = username.toString()
        ..fields['password'] = password.toString()
        ..fields['scope'] = 'profile'
        ..fields['grant_type'] = 'password';
    }
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      _writeToStorage(respStr);
    }
    return {"statusCode": response.statusCode, "body": jsonDecode(respStr)};
  }
}
