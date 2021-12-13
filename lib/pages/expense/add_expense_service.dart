import 'package:budgetium/pages/expense/add_expense.dart';
import 'package:budgetium/pages/expense/expense.dart';
import 'package:budgetium/services/graphql_client_util.dart';
import 'package:graphql/client.dart';
import 'package:budgetium/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AddExpenseService {
  bool testingFlag;
  AddExpenseService({this.testingFlag = false});

  Future<dynamic> addExpense({GraphQLUtil? graphUtil, GraphQLClient? client, expenseObj}) async {
    if (graphUtil == null) graphUtil = new GraphQLUtil();
    final String _token = await graphUtil.getCurrentToken();
    if (client == null) final GraphQLClient client = graphUtil.createBudgetiumClient(_token);

    final MutationOptions options = MutationOptions(
        document: gql(
          r'''
        mutation ($expense_ammount:Int!,$expense_category:String,$expense_description:String){
          addExpense(input:{
          amount:$expense_ammount,
          category:$expense_category,
          expense_description:$expense_description
          }) {
            amount
          }
        }
      ''',
        ),
        variables: expenseObj);
    final QueryResult result = await client!.mutate(options);
    if (result.hasException) {
      throw Exception(result.exception);
    }
    return result.data;
  }
}
