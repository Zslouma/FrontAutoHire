import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/models/EvaluationModel.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/widget/rating.dart';

import 'ListEvaluation.dart';

class ListEmployee extends StatefulWidget {
  final String idC;

  ListEmployee({Key key, this.idC}) : super(key: key);

  @override
  _ListEmployeeState createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  String idEmp;

  getEmployee() async {
    var res = await http.get(Uri.http(Utils.url, "/user/e/" + widget.idC));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  Future<EvaluationModel> createAvis(
      String entreprise,
      String employee,
      String comment,
      int niveau1,
      int niveau2,
      int niveau3,
      int niveau4,
      int niveau5,
      int niveau6) async {
    final response = await http.post(
        Uri.http(Utils.url, Utils.evaluation + '/newEvaluation'),
        headers: headers,
        body: jsonEncode({
          "integrity": niveau1,
          "planification": niveau2,
          "ponctuality": niveau3,
          "innovation": niveau4,
          "motivation": niveau5,
          "amelioration": niveau6,
          "commentaire": comment,
          "entreprise": entreprise,
          "employee": employee
        }));

    if (response.statusCode == 201) {
      print(response.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getEmployee(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Scaffold(
                body: new Stack(
                  children: <Widget>[
                    new Center(
                        child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        bottom: 12.0, left: 10.0, right: 10.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: SizedBox(
                                                height: 50.0,
                                                width: 50.0,
                                                child: ClipRRect(
                                                  child: Image.asset(
                                                      "assets/images/Welcome.png"),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        snapshot.data[index]
                                                            ["username"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      // deleteee
                                                      /* icon: Icon(Icons.delete),
                                  onPressed: () => confirtDelete(
                                      snapshot.data[index]['id'], context),*/
                                                      icon: Icon(Icons
                                                          .rate_review_outlined),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      onPressed: () {
                                                        idEmp = snapshot
                                                            .data[index]['id'];
                                                        _RatingModalBottomSheet(
                                                            context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ["email"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 50.0, top: 10.0),
                                          height: 1.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              String idCmp = snapshot.data[index]['id'];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListEvaluation(idC: idCmp)),
                              );
                            },
                          ),
                        );
                      },
                    )),
                  ],
                ),
              );

              /*
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
                        return Card(
                          elevation: 10,
                          child: InkWell(
                            child: ListTile(
                              selectedTileColor: Colors.black,
                              leading: Icon(Icons.arrow_drop_down_circle),
                              title: Text(snapshot.data[index]['username'],
                                  style: TextStyle(color: Colors.white)),
                              tileColor: Color(0xFFC51162),
                              subtitle: Text(snapshot.data[index]['email'],
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                // deleteee
                                /* icon: Icon(Icons.delete),
                                  onPressed: () => confirtDelete(
                                      snapshot.data[index]['id'], context),*/
                                icon: Icon(Icons.rate_review_outlined),
                                padding: const EdgeInsets.only(right: 15),
                                onPressed: () {
                                  idEmp = snapshot.data[index]['id'];
                                  _RatingModalBottomSheet(context);
                                },
                              ),
                            ),
                            onTap: () {
                              String idCmp = snapshot.data[index]['id'];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListEvaluation(idC: idCmp)),
                              );
                            },
                          ),
                        );
                      },
                    ))
                  ],
                ),
                bottomNavigationBar:
                    CustomBottomNavBar(selectedMenu: MenuState.message),
              );*/
            } else {
              return Center(child: Text("hi ena list employee wahdi"));
            }
          },
        ),
      ),
    );
  }

  confirtDelete(id, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("delete"),
              content: Text("are you sure"),
              actions: [
                TextButton(
                  child: Text("yes"),
                  onPressed: () async {
                    print("dddddddddddddddddd" + id);
                    await http.delete(
                        Uri.http(Utils.url, Utils.user + 'delete/' + id));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListEmployee()));
                  },
                ),
                TextButton(
                  child: Text("no"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void _RatingModalBottomSheet(context) {
    int _rating1, _rating2, _rating3, _rating4, _rating5, _rating6;
    int result;
    EvaluationModel _avis;
    final TextEditingController commentController = TextEditingController();
    /*avg = (s / l).round();
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
    }*/
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
                height: MediaQuery.of(context).size.height * .60,
                child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("        ingegrity      "),
                                Rating((rating) {
                                  setState(() {
                                    _rating1 = rating;
                                  });
                                }, 5),
                              ],
                            ),
                            Row(
                              children: [
                                Text("        planification      "),
                                Rating((rating) {
                                  setState(() {
                                    _rating2 = rating;
                                  });
                                }, 5),
                              ],
                            ),
                            Row(
                              children: [
                                Text("        ponctuality      "),
                                Rating((rating) {
                                  setState(() {
                                    _rating3 = rating;
                                  });
                                }, 5),
                              ],
                            ),
                            Row(
                              children: [
                                Text("        innovation      "),
                                Rating((rating) {
                                  setState(() {
                                    _rating4 = rating;
                                  });
                                }, 5),
                              ],
                            ),
                            Row(
                              children: [
                                Text("        motivation      "),
                                Rating((rating) {
                                  setState(() {
                                    _rating5 = rating;
                                  });
                                }, 5),
                              ],
                            ),
                            Row(
                              children: [
                                Text("        amelioration      "),
                                Rating((rating) {
                                  setState(() {
                                    _rating6 = rating;
                                  });
                                }, 5),
                              ],
                            ),
                            Row(
                              children: [
                                Text("        comment      "),
                                Container(
                                  width: 200.0,
                                  child: TextField(
                                      controller: commentController,
                                      style: TextStyle(color: Colors.pink)),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final String entreprise = widget.idC;
                                    final String employee = idEmp;
                                    final String comment =
                                        commentController.text;
                                    final int niveau1 = _rating1;
                                    final int niveau2 = _rating2;
                                    final int niveau3 = _rating3;
                                    final int niveau4 = _rating4;
                                    final int niveau5 = _rating5;
                                    final int niveau6 = _rating6;
                                    final EvaluationModel avis =
                                        await createAvis(
                                            entreprise,
                                            employee,
                                            comment,
                                            niveau1,
                                            niveau2,
                                            niveau3,
                                            niveau4,
                                            niveau5,
                                            niveau6);

                                    setState(() {
                                      _avis = avis;
                                    });
                                  },
                                  tooltip: 'Increment',
                                  icon: Icon(Icons.rate_review),
                                ),
                              ],
                            ),
                            _avis == null
                                ? Container()
                                : Text(
                                    "The user ${_avis.entreprise} is created successfully at time ${_avis.createdAt.toIso8601String()}"),
                          ],
                        ),
                      ],
                    )));
          });
        });
  }
}
