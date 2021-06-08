import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multipart_request/multipart_request.dart';

import 'package:http/http.dart' as http;
import 'package:slouma_v1/utils/utils.dart';

String imagePath = "";

// ignore: camel_case_types
class validationBody extends StatelessWidget {
  int index = 1;
  String tit = 'Profil Validation';
  String sub = 'compare with your linkedin profil';

  fetchPost() async {
    // <------ CHANGED THIS LINE
    var url = Uri.parse(Utils.url2 + '/user/validateResume');

    final response = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({"username": "taherhamzaouii"}));

    if (response.statusCode == 200) {
      print('RETURNING: ' + response.body);

      return response.body; // <------ CHANGED THIS LINE
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  floatingActionButton: index == 1
                      ? FloatingActionButton(
                          onPressed: () {
                            if (snapshot.data != "") {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text(
                                            "Unable to validate your profil !"),
                                        content: new Text(
                                            "Missing skills from linkedin : " +
                                                snapshot.data),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("Congratulations!"),
                                        content: new Text(
                                            "Your profil details matches your linkedin's "),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            }
                          },
                          backgroundColor: Colors.pink,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : null,
                  floatingActionButtonLocation: index == 1
                      ? FloatingActionButtonLocation.centerFloat
                      : null,
                  backgroundColor: Colors.white,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/linked.png"))),
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Text(
                        tit,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.5,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Text(
                          sub,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.deepPurpleAccent),
                      backgroundColor: Colors.blueGrey,
                      strokeWidth: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  "Please Wait!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.5,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(
                    "Getting Details From Your Linkedin Profil",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            );
          }),
    ));
  }
}
