import 'package:graphql/client.dart';
import 'package:budgetium/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class GraphQLUtil {
  bool testingFlag;
  GraphQLUtil({this.testingFlag = false});
  GraphQLClient createBudgetiumClient(String token, {GraphQLClient? client}) {
    final Link _link = HttpLink(AppConfig.coreURL, defaultHeaders: {'Authorization': token});
    if (client != null) {
      return client;
    }
    return GraphQLClient(link: _link, cache: GraphQLCache());
  }

  Future getCurrentToken({FlutterSecureStorage? storage}) async {
    FlutterSecureStorage _storage;
    if (storage != null) {
      _storage = storage;
    } else {
      _storage = new FlutterSecureStorage();
    }
    var localStore = await _storage.read(key: 'key');
    var localStoreData = jsonDecode(localStore.toString());
    return localStoreData['token_type'] + " " + localStoreData['access_token'];
  }
}
