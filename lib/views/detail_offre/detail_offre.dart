import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slouma_v1/models/AvisModel.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/views/widget/affRating1.dart';
import 'package:slouma_v1/views/widget/affRating2.dart';
import 'package:slouma_v1/views/widget/affRating3.dart';
import 'package:slouma_v1/views/widget/affRating4.dart';
import 'package:slouma_v1/views/widget/affRating5.dart';
import 'package:slouma_v1/views/widget/affRatingEmpty.dart';
import 'package:slouma_v1/views/widget/rating.dart';
import 'package:slouma_v1/models/EvaluationModel.dart';

class DetailOffre extends StatefulWidget {
  static String routeName = "/detail_offre";
  int colorVal;
  final String idC;
  String idEmp;
  int _rating;
  int avg, s = 0;

  int result, l;
  getAvis() async {
    var res = await http.get(Uri.http(Utils.url, "/avis/e/" + idC));
    print(res);
    if (res.statusCode == 200) {
      print(res);

      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  AvisModel _avis;
  final TextEditingController commentController = TextEditingController();
  Future<EvaluationModel> createAvis1(
      String entreprise,
      String employee,
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
          "commentaire": "test",
          "entreprise": entreprise,
          "employee": employee
        }));

    if (response.statusCode == 201) {
      print(response.body);
    } else {
      return null;
    }
  }

  getEmployee() async {
    var res = await http.get(Uri.http(Utils.url, "/user/e/" + idC));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  getOffres() async {
    var res = await http.get(Uri.http(Utils.url, "/offre/e/" + idC));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  Future<AvisModel> createAvis(
      String entreprise, String user, String comment, int niveau) async {
    final response =
        await http.post(Uri.http(Utils.url, Utils.avis + '/newAvis'),
            headers: headers,
            body: jsonEncode({
              "niveau": niveau,
              "commentaire": comment,
              "entreprise": entreprise,
              "personne": user
            }));

    if (response.statusCode == 201) {
      print(response.body);
    } else {
      return null;
    }
  }

  getComp() async {
    var res = await http.get(Uri.http(Utils.url, "/entreprise/n/" + idC));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  void getidfromjson() {}

  DetailOffre({Key key, this.idC, this.colorVal}) : super(key: key);

  @override
  _DetailOffreState createState() => _DetailOffreState();
}

class _DetailOffreState extends State<DetailOffre>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      widget.colorVal = 0x802196F3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.blue,
          expandedHeight: 160.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.idC),
            background: FlutterLogo(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 550.0,
                child: Center(
                  child: innerNestedTabs(widget.idC),
                ),
              );
            },
            childCount: 1,
          ),
        ),
      ]),
    );
  }

  Widget innerNestedTabs(idC) {
    return DefaultTabController(
      length: 4,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            child: new SafeArea(
              child: Column(
                children: <Widget>[
                  new Expanded(child: new Container()),
                  new TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding: EdgeInsets.all(10.0),
                    indicatorColor: Colors.blue,
                    indicatorWeight: 5.0,
                    tabs: [
                      Text("About",
                          style: TextStyle(
                              color: _tabController.index == 0
                                  ? Colors.grey
                                  : Colors.black)),
                      Text("Raitings",
                          style: TextStyle(
                              color: _tabController.index == 1
                                  ? Colors.grey
                                  : Colors.black)),
                      Text("Employees",
                          style: TextStyle(
                              color: _tabController.index == 2
                                  ? Colors.grey
                                  : Colors.black)),
                      Text("Jobs",
                          style: TextStyle(
                              color: _tabController.index == 3
                                  ? Colors.grey
                                  : Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                child: FutureBuilder(
                  future: widget.getComp(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        child: new Stack(
                          children: <Widget>[
                            new Center(
                                child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(
                                            bottom: 35.0,
                                            left: 10.0,
                                            right: 10.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 05.0,
                                                                  top: 10.0),
                                                          child: Text(
                                                            "Company Details",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 20.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 05.0,
                                                          top: 10.0),
                                                      child: Text(
                                                        "Adress : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 05.0,
                                                          top: 10.0),
                                                      child: Text(
                                                        snapshot.data[index]
                                                            ["adresse"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 05.0,
                                                          top: 10.0),
                                                      child: Text(
                                                        "About : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 05.0,
                                                          top: 10.0),
                                                      child: SizedBox(
                                                        width: 350,
                                                        child: Text(
                                                          snapshot.data[index]
                                                              ["about"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 05.0,
                                                          top: 10.0),
                                                      child: Text(
                                                        "Rate Company !",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 05.0,
                                                            top: 10.0),
                                                        child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .50,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        1.0),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Rating((rating) {
                                                                              setState(() {
                                                                                widget._rating = rating;
                                                                              });
                                                                            }, 5),
                                                                            Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                  width: 230,
                                                                                  child: TextField(
                                                                                    controller: widget.commentController,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 20,
                                                                                ),
                                                                                ElevatedButton(
                                                                                  child: Text('Rate !'),
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    primary: Colors.pink,
                                                                                    onPrimary: Colors.white,
                                                                                    shadowColor: Colors.red,
                                                                                    elevation: 5,
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    final String entreprise = widget.idC;
                                                                                    final String user = "idUser";
                                                                                    final String comment = widget.commentController.text;
                                                                                    final int niveau = widget._rating;
                                                                                    final AvisModel avis = await widget.createAvis(entreprise, user, comment, niveau);
                                                                                    widget.commentController.clear();
                                                                                    Rating((rating) {
                                                                                      setState(() {
                                                                                        widget._rating = 0;
                                                                                      });
                                                                                    }, 0);
                                                                                    Get.snackbar("Add success", "Thanks for feedback", backgroundColor: Colors.white, colorText: Color(0xFF1A1E78), snackPosition: SnackPosition.BOTTOM);
                                                                                    setState(() {
                                                                                      widget._avis = avis;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            widget._avis == null
                                                                                ? Container()
                                                                                : Text("The user ${widget._avis.entreprise} is created successfully at time ${widget._avis.createdAt.toIso8601String()}"),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text(idC));
                    }
                  },
                ),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: widget.getAvis(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Container(
                      child: new Stack(
                        children: <Widget>[
                          new Center(
                              child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              widget.l = snapshot.data.length;
                              widget.s =
                                  widget.s + snapshot.data[index]['niveau'];
                              widget.avg = (widget.s / widget.l).round();
                              if ((widget.avg <= 1)) {
                                widget.result = 1;
                              } else if (widget.avg <= 2) {
                                widget.result = 2;
                              } else if (widget.avg <= 3) {
                                widget.result = 3;
                              } else if (widget.avg <= 4) {
                                widget.result = 4;
                              } else if (widget.avg > 4) {
                                widget.result = 5;
                              } else {
                                widget.result = 0;
                              }
                              return Container(
                                child: Column(children: <Widget>[
                                  Container(
                                      child: Column(children: <Widget>[
                                    ListTile(
                                      selectedTileColor: Colors.black,
                                      leading: Icon(
                                        Icons.account_circle,
                                        size: 50,
                                      ),
                                      subtitle: Container(
                                        margin: EdgeInsets.only(
                                            left: 0.0, top: 10.0),
                                        child: Text(
                                          snapshot.data[index]['commentaire'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                      tileColor: Color(0xFFFFFF),
                                      title: Container(
                                        margin: EdgeInsets.only(
                                            left: 0.0, top: 10.0, right: 170),
                                        child: widget.result == 0
                                            ? RatingEmpty((rating) {},
                                                5) //code if above statement is true
                                            : widget.result == 1
                                                ? Rating1((rating) {}, 5)
                                                : widget.result == 2
                                                    ? Rating2((rating) {}, 5)
                                                    : widget.result == 3
                                                        ? Rating3(
                                                            (rating) {}, 5)
                                                        : widget.result == 4
                                                            ? Rating4(
                                                                (rating) {}, 5)
                                                            : Rating5(
                                                                (rating) {}, 5),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 0.0, top: 10.0),
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ]))
                                ]),
                              );
                            },
                          ))
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text("hi ena list employee wahdi"));
                  }
                },
              ),
            ),
            Container(
              child: Center(
                child: FutureBuilder(
                  future: widget.getEmployee(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        child: new Stack(
                          children: <Widget>[
                            new Center(
                                child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  bottom: 12.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10.0),
                                                        child: SizedBox(
                                                          height: 50.0,
                                                          width: 50.0,
                                                          child: ClipRRect(
                                                            child: Image.asset(
                                                                "assets/images/visa.png"),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      "username"],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .rate_review_outlined),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            15),
                                                                onPressed: () {
                                                                  idC = snapshot
                                                                          .data[
                                                                      index]['id'];
                                                                  _RatingModalBottomSheet(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              snapshot.data[
                                                                      index]
                                                                  ["username"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              snapshot.data[
                                                                      index]
                                                                  ["email"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 40.0, top: 10.0),
                                                    height: 1.0,
                                                    color: Colors.grey[300],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text(idC));
                    }
                  },
                ),
              ),
            ),
            Container(
              child: Center(
                child: FutureBuilder(
                  future: widget.getOffres(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        child: new Stack(
                          children: <Widget>[
                            new Center(
                                child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  bottom: 12.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10.0),
                                                        child: SizedBox(
                                                          height: 50.0,
                                                          width: 50.0,
                                                          child: ClipRRect(
                                                            child: Image.asset(
                                                                "assets/images/visa.png"),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  snapshot.data[
                                                                          index]
                                                                      ["titre"],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              snapshot.data[
                                                                      index]
                                                                  ["poste"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              snapshot.data[
                                                                      index]
                                                                  ["address"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 40.0, top: 10.0),
                                                    height: 1.0,
                                                    color: Colors.grey[300],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text(idC));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                            Center(
                              child: ElevatedButton(
                                child: Text('Rate !'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.pink,
                                  onPrimary: Colors.white,
                                  shadowColor: Colors.red,
                                  elevation: 5,
                                ),
                                onPressed: () async {
                                  final String entreprise = widget.idC;
                                  final String employee = widget.idEmp;
                                  final String comment = commentController.text;
                                  final int niveau1 = _rating1;
                                  final int niveau2 = _rating2;
                                  final int niveau3 = _rating3;
                                  final int niveau4 = _rating4;
                                  final int niveau5 = _rating5;
                                  final int niveau6 = _rating6;
                                  final EvaluationModel avis =
                                      await widget.createAvis1(
                                          entreprise,
                                          employee,
                                          niveau1,
                                          niveau2,
                                          niveau3,
                                          niveau4,
                                          niveau5,
                                          niveau6);
                                  Navigator.pop(context);
                                  setState(() {
                                    _avis = avis;
                                  });
                                  Get.snackbar(
                                      "Add success", "Thanks for feedback",
                                      backgroundColor: Colors.white,
                                      colorText: Color(0xFF1A1E78),
                                      snackPosition: SnackPosition.BOTTOM);
                                },
                              ),
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
