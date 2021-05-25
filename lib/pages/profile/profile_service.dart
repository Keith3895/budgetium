import 'package:graphql/client.dart';
import 'package:budgetium/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ProfileService {
  GraphQLClient createBudgetiumClient(String token) {
    final Link _link = HttpLink(AppConfig.coreURL, defaultHeaders: {'Authorization': token});
    return GraphQLClient(link: _link, cache: GraphQLCache());
  }

  Future getMyData() async {
    final String _token = await getCurrentToken();
    final GraphQLClient _client = createBudgetiumClient(_token);
    final QueryOptions options = QueryOptions(
        document: gql(
      r'''
        query {
          me {
            name
            email
            mobile
          }
        }
      ''',
    ));
    final QueryResult result = await _client.query(options);

    if (result.hasException) {}
    return result.data!['me'];
  }

  Future getCurrentToken() async {
    FlutterSecureStorage? _storage = new FlutterSecureStorage();
    var localStore = await _storage.read(key: 'key');
    var localStoreData = jsonDecode(localStore.toString());
    return localStoreData['token_type'] + " " + localStoreData['access_token'];
  }
}
