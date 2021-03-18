import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/enums.dart';
import 'package:slouma_v1/models/AvisModel.dart';
import "package:slouma_v1/utils/utils.dart";
import 'package:slouma_v1/views/widget/rating.dart';

class ListCompany extends StatelessWidget {
  String idCompany;
  int s = 0;
  int l;
  int avg;

  getCompany() async {
    var res = await http.get(Uri.http(Utils.url, Utils.company));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  getAvis() async {
    var res = await http.get(Uri.http(Utils.url, Utils.avis));
    print(res);
    if (res.statusCode == 200) {
      print(res);

      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

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

  static String routeName = "/list_c";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getCompany(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              l = snapshot.data.length;

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
                        // s = s + snapshot.data[index]['niveau'];

                        return Card(
                          elevation: 10,
                          child: ListTile(
                            selectedTileColor: Colors.black,
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(snapshot.data[index]['nom'],
                                style: TextStyle(color: Colors.white)),
                            tileColor: Color(0xFFC51162),
                            subtitle: Text(snapshot.data[index]['industry'],
                                style: TextStyle(color: Colors.white)),
                            trailing: IconButton(
                              // deleteee
                              /* icon: Icon(Icons.delete),
                              onPressed: () => confirtDelete(
                                  snapshot.data[index]['id'], context),*/
                              icon: Icon(Icons.rate_review_outlined),
                              padding: const EdgeInsets.only(right: 15),
                              onPressed: () {
                                idCompany = snapshot.data[index]['id'];
                                _RatingModalBottomSheet(context);
                              },
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                ),
                bottomNavigationBar:
                    CustomBottomNavBar(selectedMenu: MenuState.home),
              );
            } else {
              return Center(child: Text("hi ena list company wahdi"));
            }
          },
        ),
        /*child: FutureBuilder(
          future: getCompany(),
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
                          child: ListTile(
                            selectedTileColor: Colors.black,
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(snapshot.data[index]['nom'],
                                style: TextStyle(color: Colors.white)),
                            tileColor: Color(0xFFC51162),
                            subtitle: Text(snapshot.data[index]['industry'],
                                style: TextStyle(color: Colors.white)),
                            trailing: IconButton(
                              // deleteee
                              /* icon: Icon(Icons.delete),
                              onPressed: () => confirtDelete(
                                  snapshot.data[index]['id'], context),*/
                              icon: Icon(Icons.rate_review_outlined),
                              padding: const EdgeInsets.only(right: 15),
                              onPressed: () {
                                idCompany = snapshot.data[index]['id'];
                                _RatingModalBottomSheet(context);
                              },
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                ),
                bottomNavigationBar:
                    CustomBottomNavBar(selectedMenu: MenuState.home),
              );
            } else {
              return Center(child: Text("hi ena list company wahdi"));
            }
          },
        ),*/
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
                        Uri.http(Utils.url, '/entreprise/delete/' + id));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListCompany()));
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
    int _rating;
    int result;
    AvisModel _avis;
    final TextEditingController commentController = TextEditingController();
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
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
                height: MediaQuery.of(context).size.height * .69,
                child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Rating((rating) {
                              setState(() {
                                _rating = rating;
                              });
                            }, 5),
                            TextField(
                              controller: commentController,
                            ),
                            IconButton(
                              onPressed: () async {
                                final String entreprise = idCompany;
                                final String user = "idUser";
                                final String comment = commentController.text;
                                final int niveau = _rating;
                                final AvisModel avis = await createAvis(
                                    entreprise, user, comment, niveau);

                                setState(() {
                                  _avis = avis;
                                });
                              },
                              tooltip: 'Increment',
                              icon: Icon(Icons.add),
                            ),
                            FutureBuilder(
                              future: getAvis(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  /*  return ListView(children: [
                                    ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 10,
                                          child: ListTile(
                                            title: Text(
                                                snapshot.data[index]
                                                    ['commentaire'],
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        );
                                      },
                                    ),
                                  ]);
*/
                                  /*   return new Row(children: <Widget>[
                                    Expanded(
                                        child: SizedBox(
                                      height: 20.0,
                                      child: new ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          child:
                                          new ListTile(
                                              leading:
                                                  new Icon(Icons.music_note),
                                              title: new Text(
                                                  snapshot.data[index]['nom']),
                                              onTap: () => {});
                                        },
                                      ),
                                    ))
                                  ]);*/

                                  return new Row(children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        height: 20.0,
                                        child: new ListTile(
                                            leading: new Icon(Icons.comment),
                                            title: new Text("rahy tekhdem"),
                                            onTap: () => {}),
                                      ),
                                    )
                                  ]);
                                } else {
                                  return new Row(children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        height: 20.0,
                                        child: new ListTile(
                                            leading: new Icon(Icons.music_note),
                                            title: new Text('music'),
                                            onTap: () => {}),
                                      ),
                                    )
                                  ]);
                                }
                              },
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

/*
class PopularProducts extends StatelessWidget {
  getCompany() async {
    var res = await http.get(Uri.http('192.168.43.94:3000', '/entreprise'));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (<Widget>[
              Expanded(
                child: FutureBuilder(
                  future: getCompany(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(snapshot.data[index]['nom']),
                              subtitle: Text(snapshot.data[index]['industry']),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  //onPressed: () => print("good")
                                  confirtDelete(snapshot.data[index]['id'], context),
                                  ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("hi"));
                    }
                  },
                ),
              )
            ]),
          ),
        )
      ],
    );
  }*/
