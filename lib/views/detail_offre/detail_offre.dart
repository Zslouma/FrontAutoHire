import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DetailOffre extends StatefulWidget {
  static String routeName = "/detail_offre";
  int colorVal;
  final String idC;

  getEmployee() async {
    var res = await http.get(Uri.http(Utils.url, "/user/e/" + idC));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
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
    _tabController = new TabController(vsync: this, length: 3);
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
                height: 450.0,
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
      length: 3,
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
                      Text("Jobs",
                          style: TextStyle(
                              color: _tabController.index == 0
                                  ? Colors.grey
                                  : Colors.black)),
                      Text("About",
                          style: TextStyle(
                              color: _tabController.index == 1
                                  ? Colors.grey
                                  : Colors.black)),
                      Text("Employees",
                          style: TextStyle(
                              color: _tabController.index == 2
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
              height: 200.0,
              child: Center(child: Text('TOP RATED')),
            ),
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
                                                            "Nom de l'entreprise : " +
                                                                snapshot.data[
                                                                        index]
                                                                    ["nom"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18.0,
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
                                                        "Description : " +
                                                            snapshot.data[index]
                                                                ["about"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 05.0,
                                                          top: 10.0),
                                                      child: Text(
                                                        "Adresse : " +
                                                            snapshot.data[index]
                                                                ["adresse"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
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
                                                Flexible(
                                                    child: Image.asset(
                                                  "assets/images/visa.png",
                                                  fit: BoxFit.fill,
                                                )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15.0,
                                                                  top: 10.0),
                                                          child: Text(
                                                            snapshot.data[index]
                                                                ["username"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 28.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 35,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 0.0, top: 10.0),
                                                      child: Text(
                                                        snapshot.data[index]
                                                            ["username"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        snapshot.data[index]
                                                            ["email"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.green),
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
                                              color: Colors.red[300],
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
          ],
        ),
      ),
    );
  }
}
