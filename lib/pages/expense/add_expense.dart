import 'dart:io';

import 'package:budgetium/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app_config.dart';

class AddExpense extends StatefulWidget {
  @override
  AddExpenseState createState() {
    return AddExpenseState();
  }
}

class AddExpenseState extends State<AddExpense> {
  var _formKey = GlobalKey<FormState>();
  String ammount_value = "";
  String expense_description_value = "";
  String category_value = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        height: (MediaQuery.of(context).size.height * .8),
        // color: Colors.amber,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Expense',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                      )
                    ],
                  )),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(child: ammount(null)),
                    Container(
                      child: expense_description(null),
                    ),
                    Container(
                      child: categoryPicker(null),
                    ),
                    Container(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            children: [saveAndAd(), save()],
                          )),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        )
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       const Text('Modal BottomSheet'),
        //       ElevatedButton(
        //         child: const Text('Close BottomSheet'),
        //         onPressed: () => Navigator.pop(context),
        //       )
        //     ],
        //   ),
        // ),
        );
  }

  Widget ammount(data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: new EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          key: Key('ammount'),
          decoration: InputDecoration(labelText: "Enter Ammount", filled: true),
          validator: (value) => FieldValidators.nullValidator(value.toString(), "Ammount"),
          onSaved: (value) {
            setState(() {
              ammount_value = value.toString();
            });
          },
        ),
      ),
    );
  }

  Widget expense_description(data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: new EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          key: Key('expense_description'),
          decoration: InputDecoration(labelText: "What was this for?", filled: true),
          // validator: (value) => FieldValidators.validateName(value.toString()),
          onSaved: (value) {
            setState(() {
              ammount_value = value.toString();
            });
          },
        ),
      ),
    );
  }

  Widget categoryPicker(data) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Category", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15))
                    ],
                  ),
                  Wrap(
                      direction: Axis.horizontal,
                      spacing: 40,
                      children: <Widget>[...icBs.map((e) => iconButton_itter(e))]),
                ],
              )),
        ));
  }

  Widget iconButton_itter(data) {
    return Column(
      children: [
        IconButton(
            onPressed: () => {
                  setState(() {
                    category_value = data['value'].toString();
                  })
                },
            icon: Icon(
              data['icon'],
              color: data['value'].toString() == category_value ? Colors.blue : Colors.black,
            )),
        SizedBox(
            width: 60.0,
            child: Text(
              data['value'],
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: data['value'].toString() == category_value ? Colors.blue : Colors.black),
            ))
      ],
    );
  }

  var icBs = [
    {"value": "BILLS", "icon": Icons.description_outlined},
    {"value": "EMI", "icon": Icons.stacked_bar_chart_sharp},
    {"value": "HEALTH", "icon": Icons.favorite_border},
    {"value": "TRAVEL", "icon": Icons.local_airport},
    {"value": "SAVINGS", "icon": Icons.savings},
    {"value": "GROCERY", "icon": Icons.local_grocery_store_outlined},
    {"value": "OTHER", "icon": Icons.pending}
  ];

  Widget saveAndAd() {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
      child: Text(
        'Save And Add Another',
        style: TextStyle(fontSize: 14),
      ),
      onPressed: () => {},
    );
  }

  Widget save() {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
      child: Text(
        'Save',
        style: TextStyle(fontSize: 14),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          var formSubmit_value = {
            "ammount": ammount_value,
            "category": category_value,
            "expense_description": expense_description_value
          };
          Navigator.pop(context);
        }
        // await save_expense();
      },
    );
  }

  Future save_expense(var expenseObj, http.Client? client) async {
    if (client == null) client = http.Client();
    String _coreIRL = AppConfig.coreURL;
    var _url = Uri.parse('$_coreIRL//');
    var response = await client.post(_url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: utf8.encode(json.encode(expenseObj)));
    return {"statusCode": response.statusCode, "body": jsonDecode(response.body)};
  }
}
