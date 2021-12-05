import 'package:budgetium/pages/expense/add_expense.dart';
import 'package:budgetium/services/graphql_client_util.dart';
import 'package:graphql/client.dart';
import 'package:budgetium/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AddExpenseService {
  bool testingFlag;
  AddExpenseService({this.testingFlag = false});

  Future<dynamic> addExpense(
      {GraphQLClient? client, FlutterSecureStorage? storage, GraphQLUtil? graphUtil}) async {
    if (graphUtil == null) graphUtil = new GraphQLUtil();
    final String _token = await graphUtil.getCurrentToken(storage: storage);
    final GraphQLClient _client = graphUtil.createBudgetiumClient(_token, client: client);
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
}
