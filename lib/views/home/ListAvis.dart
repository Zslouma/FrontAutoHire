import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';

import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/widget/affRating1.dart';
import 'package:slouma_v1/views/widget/affRating2.dart';
import 'package:slouma_v1/views/widget/affRating3.dart';
import 'package:slouma_v1/views/widget/affRating4.dart';
import 'package:slouma_v1/views/widget/affRating5.dart';
import 'package:slouma_v1/views/widget/affRatingEmpty.dart';

import '../../enums.dart';

class ListAvis extends StatelessWidget {
  final String idA;
  String idEmp;
  int avg, s = 0;

  int result, l;
  ListAvis({Key key, this.idA}) : super(key: key);
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  getAvis() async {
    var res = await http.get(Uri.http(Utils.url, "/avis/e/" + idA));
    print(res);
    if (res.statusCode == 200) {
      print(res);

      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder(
          future: getAvis(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Scaffold(
                body: new Stack(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Welcome.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Center(
                        child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        l = snapshot.data.length;
                        s = s + snapshot.data[index]['niveau'];
                        avg = (s / l).round();
                        if ((avg <= 1)) {
                          result = 1;
                        } else if (avg <= 2) {
                          result = 2;
                        } else if (avg <= 3) {
                          result = 3;
                        } else if (avg <= 4) {
                          result = 4;
                        } else if (avg > 4) {
                          result = 5;
                        } else {
                          result = 0;
                        }
                        return Center(
                          child: Card(
                              elevation: 10,
                              child: Column(children: [
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(Icons.arrow_drop_down_circle),
                                  title: Text(
                                    snapshot.data[index]['commentaire'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: result == 0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : result == 1
                                          ? Rating1((rating) {}, 5)
                                          : result == 2
                                              ? Rating2((rating) {}, 5)
                                              : result == 3
                                                  ? Rating3((rating) {}, 5)
                                                  : result == 4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ])),
                        );
                      },
                    ))
                  ],
                ),
                bottomNavigationBar:
                    CustomBottomNavBar(selectedMenu: MenuState.message),
              );
            } else {
              return Center(child: Text("hi ena list employee wahdi"));
            }
          },
        ),
      ),
    );
  }
}
