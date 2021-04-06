import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/utils/utils.dart';

import '../../enums.dart';

class ListTest extends StatelessWidget {
  getCompany() async {
    var res = await http.get(Uri.http(Utils.url, Utils.test));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  static String routeName = "/list_t";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: menuTest(),
      extendBody: true,
      endDrawer: Container(
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: ClipRRect(
            child: Image.asset("assets/images/visa.png"),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }

  Container menuTest() {
    return Container(
      child: SizedBox(
        child: FutureBuilder(
          future: getCompany(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Scaffold(
                body: new Stack(
                  children: <Widget>[
                    new Container(
                        margin: EdgeInsets.only(top: 30.0),
                        padding: EdgeInsets.only(bottom: 10.0, top: 30.0),
                        child: listHorizental(snapshot)),
                    new Container(
                      margin: EdgeInsets.only(left: 35.0, top: 250.0),
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: Text(
                        "Hne nhotou Pub ken bch tekhdem l app",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                            color: Colors.black),
                      ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(top: 370.0),
                        padding: EdgeInsets.only(top: 10, bottom: 10.0),
                        child: ListView.builder(
                          clipBehavior: Clip.hardEdge,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10.0, bottom: 25.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        bottom: 35.0, left: 35.0, right: 10.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 20.0),
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
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        snapshot.data[index]
                                                            ["question"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 28.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        icon:
                                                            Icon(Icons.delete),
                                                        onPressed: () =>
                                                            confirtDelete(
                                                                snapshot.data[
                                                                        index]
                                                                    ["id"],
                                                                context))
                                                  ],
                                                ),
                                                Container(
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ["reponseA"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ["sujet"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14.0,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10.0, top: 10.0),
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
                        ))
                  ],
                ),
              );
            } else {
              return Center(child: Text("hi ena list test wahdi"));
            }
          },
        ),
      ),
    );
  }

  ListView listHorizental(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      clipBehavior: Clip.hardEdge,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 8.0,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 35.0, left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Image.asset(
                          "assets/images/visa.png",
                          fit: BoxFit.fill,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 15.0, top: 10.0),
                                  child: Text(
                                    snapshot.data[index]["sujet"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 28.0,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => confirtDelete(
                                        snapshot.data[index]["id"], context))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 0.0, top: 10.0),
                              child: Text(
                                snapshot.data[index]["question"],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              child: Text(
                                snapshot.data[index]["reponseA"],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50.0, top: 10.0),
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
                        Uri.http(Utils.url, Utils.test + 'delete/' + id));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListTest()));
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
}
