import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:slouma_v1/models/TestModel.dart';

class InsertTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InsertTestState();
  }
}

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
};

// ignore: missing_return
Future<TestModel> createTest(
    String question, String reponse, String sujet) async {
  final response = await http.post(
      Uri.http('192.168.43.94:3000', '/test/newTest'),
      headers: headers,
      body: jsonEncode(
          {"question": question, "reponse": reponse, "sujet": sujet}));

  if (response.statusCode == 201) {
    print(response.body);
  } else {
    print(response.statusCode);
  }
}

class InsertTestState extends State<InsertTest> {
  TestModel _test;

  final TextEditingController questionController = TextEditingController();
  final TextEditingController reponseController = TextEditingController();
  final TextEditingController sujetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: questionController,
            ),
            TextField(
              controller: reponseController,
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              controller: sujetController,
            ),
            SizedBox(
              height: 32,
            ),
            _test == null
                ? Container()
                : Text(
                    "The user ${_test.question} is created successfully at time ${_test.createdAt.toIso8601String()}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String question = questionController.text;
          final String reponse = reponseController.text;
          final String sujet = sujetController.text;

          final TestModel test = await createTest(question, reponse, sujet);

          setState(() {
            _test = test;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
