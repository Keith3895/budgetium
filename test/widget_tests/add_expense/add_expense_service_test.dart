
/**
 * 
 * !!!!!!!!!!!!!!!!!!!!!!! Strugling with mocking graphql client
 * 
 * 
 */



// import 'package:flutter_test/flutter_test.dart';
// import 'package:budgetium/pages/expense/add_expense_service.dart';
// import 'package:budgetium/services/graphql_client_util.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:graphql/client.dart';
// import 'package:budgetium/app_config.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';

// import 'add_expense_service_test.mocks.dart';

// expenseStub() {
//   return {
//     "expense_ammount": 20,
//     "expense_category": 'HEALTH',
//     "expense_description": "expense_description_value"
//   };
// }

// @GenerateMocks([FlutterSecureStorage, GraphQLClient, GraphQLUtil])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   test('instance creating.', () async {
//     MockGraphQLClient _client = new MockGraphQLClient();
//     MockGraphQLUtil _graphUtil = new MockGraphQLUtil();
//     when(_graphUtil.getCurrentToken()).thenAnswer((realInvocation) async {
//       return "Bearer text";
//     });
//     // when(_graphUtil.createBudgetiumClient("Bearer text")).thenReturn(_client);
//     var options = MutationOptions(
//         document: gql(
//           r'''
//         mutation ($expense_ammount:Int!,$expense_category:String,$expense_description:String){
//           addExpense(input:{
//           amount:$expense_ammount,
//           category:$expense_category,
//           expense_description:$expense_description
//           }) {
//             amount
//           }
//         }
//       ''',
//         ),
//         variables: expenseStub());
//     when(_client.mutate(options)).thenAnswer((realInvocation) async {
//       return QueryResult(
//         data: expenseStub()['expense_ammount'],
//         exception: null,
//         source: QueryResultSource.network,
//       );
//     });
//     when(_graphUtil.createBudgetiumClient("Bearer text", client: _client)).thenReturn(_client);
//     // when(_graphUtil.createBudgetiumClient("Bearer text").mutate(options))
//     //     .thenAnswer((realInvocation) async {
//     //   return QueryResult(
//     //     data: expenseStub()['expense_ammount'],
//     //     exception: null,
//     //     source: QueryResultSource.network,
//     //   );
//     // });

//     AddExpenseService addExpenseService = new AddExpenseService(testingFlag: true);
//     var addExpenseResult = await addExpenseService.addExpense(
//         graphUtil: _graphUtil, client: _client, expenseObj: expenseStub());
//     print(addExpenseResult);
//     // expect(_client, expectedClient);
//   });
// }
