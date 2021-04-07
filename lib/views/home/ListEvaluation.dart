import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';

import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/widget/affRating3.dart';
import 'package:slouma_v1/views/widget/affRating4.dart';
import 'package:slouma_v1/views/widget/affRatingEmpty.dart';
import 'package:slouma_v1/views/widget/affRating2.dart';
import 'package:slouma_v1/views/widget/affRating1.dart';
import 'package:slouma_v1/views/widget/affRating5.dart';

import '../../enums.dart';

class ListEvaluation extends StatelessWidget {
  final String idC;
  String idEmp;
  int n1, n2, n3, n4, n5, n6;
  int T1 = 0;
  ListEvaluation({Key key, this.idC}) : super(key: key);
  getEmployee() async {
    var res = await http.get(Uri.http(Utils.url, "/evaluation/e/" + idC));

    if (res.statusCode == 200) {
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
          future: getEmployee(),
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
                        n1 = snapshot.data[index]['integrity'];
                        n2 = snapshot.data[index]['planification'];
                        n3 = snapshot.data[index]['ponctuality'];
                        n4 = snapshot.data[index]['innovation'];
                        n5 = snapshot.data[index]['motivation'];
                        n6 = snapshot.data[index]['amelioration'];
                        T1 = T1 + (n1 + n2 + n3 + n4 + n5 + n6);
                        return Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(Icons.people_outlined),
                                  title: Text(
                                    "integrity",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: snapshot.data[index]['integrity'] ==
                                          0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : snapshot.data[index]['integrity'] == 1
                                          ? Rating1((rating) {}, 5)
                                          : snapshot.data[index]['integrity'] ==
                                                  2
                                              ? Rating2((rating) {}, 5)
                                              : snapshot.data[index]
                                                          ['integrity'] ==
                                                      3
                                                  ? Rating3((rating) {}, 5)
                                                  : snapshot.data[index]
                                                              ['integrity'] ==
                                                          4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(Icons.note_add_outlined),
                                  title: Text("planification",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19.0,
                                          color: Colors.black)),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: snapshot.data[index]
                                              ['planification'] ==
                                          0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : snapshot.data[index]['planification'] ==
                                              1
                                          ? Rating1((rating) {}, 5)
                                          : snapshot.data[index]
                                                      ['planification'] ==
                                                  2
                                              ? Rating2((rating) {}, 5)
                                              : snapshot.data[index]
                                                          ['planification'] ==
                                                      3
                                                  ? Rating3((rating) {}, 5)
                                                  : snapshot.data[index][
                                                              'planification'] ==
                                                          4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(Icons.timer),
                                  title: Text(
                                    "ponctuality",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: snapshot.data[index]
                                              ['ponctuality'] ==
                                          0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : snapshot.data[index]['ponctuality'] == 1
                                          ? Rating1((rating) {}, 5)
                                          : snapshot.data[index]
                                                      ['ponctuality'] ==
                                                  2
                                              ? Rating2((rating) {}, 5)
                                              : snapshot.data[index]
                                                          ['ponctuality'] ==
                                                      3
                                                  ? Rating3((rating) {}, 5)
                                                  : snapshot.data[index]
                                                              ['ponctuality'] ==
                                                          4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading:
                                      Icon(Icons.cast_for_education_rounded),
                                  title: Text(
                                    "innovation",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: snapshot.data[index]
                                              ['innovation'] ==
                                          0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : snapshot.data[index]['innovation'] == 1
                                          ? Rating1((rating) {}, 5)
                                          : snapshot.data[index]
                                                      ['innovation'] ==
                                                  2
                                              ? Rating2((rating) {}, 5)
                                              : snapshot.data[index]
                                                          ['innovation'] ==
                                                      3
                                                  ? Rating3((rating) {}, 5)
                                                  : snapshot.data[index]
                                                              ['innovation'] ==
                                                          4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(
                                      Icons.sentiment_very_satisfied_outlined),
                                  title: Text(
                                    "motivation",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: snapshot.data[index]
                                              ['motivation'] ==
                                          0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : snapshot.data[index]['motivation'] == 1
                                          ? Rating1((rating) {}, 5)
                                          : snapshot.data[index]
                                                      ['motivation'] ==
                                                  2
                                              ? Rating2((rating) {}, 5)
                                              : snapshot.data[index]
                                                          ['motivation'] ==
                                                      3
                                                  ? Rating3((rating) {}, 5)
                                                  : snapshot.data[index]
                                                              ['motivation'] ==
                                                          4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(Icons.trending_up_sharp),
                                  title: Text(
                                    "amelioration",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: snapshot.data[index]
                                              ['amelioration'] ==
                                          0
                                      ? RatingEmpty((rating) {},
                                          5) //code if above statement is true
                                      : snapshot.data[index]['amelioration'] ==
                                              1
                                          ? Rating1((rating) {}, 5)
                                          : snapshot.data[index]
                                                      ['amelioration'] ==
                                                  2
                                              ? Rating2((rating) {}, 5)
                                              : snapshot.data[index]
                                                          ['amelioration'] ==
                                                      3
                                                  ? Rating3((rating) {}, 5)
                                                  : snapshot.data[index][
                                                              'amelioration'] ==
                                                          4
                                                      ? Rating4((rating) {}, 5)
                                                      : Rating5((rating) {}, 5),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  selectedTileColor: Colors.black,
                                  leading: Icon(Icons.note_add_rounded),
                                  title: Text(
                                    "commentaire",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                        color: Colors.black),
                                  ),
                                  tileColor: Color(0xFFFFFF),
                                  subtitle: Text(
                                    snapshot.data[index]['commentaire'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 50.0, top: 10.0),
                                  height: 3.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ));
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
