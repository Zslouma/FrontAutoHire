import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/enums.dart';
import 'package:slouma_v1/models/AvisModel.dart';
import "package:slouma_v1/utils/utils.dart";
import 'package:slouma_v1/views/widget/rating.dart';

import 'ListAvis.dart';
import 'ListEmployee.dart';

class ListCompany extends StatelessWidget {
  String idCompany;

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
                          child: InkWell(
                            child: ListTile(
                                selectedTileColor: Colors.black,
                                leading: Icon(Icons.arrow_drop_down_circle),
                                title: Text(snapshot.data[index]['nom'],
                                    style: TextStyle(color: Colors.pink)),
                                tileColor: Color(0xFFF8BBD0),
                                subtitle: Text(snapshot.data[index]['industry'],
                                    style: TextStyle(color: Colors.pink)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
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
                                    IconButton(
                                      icon: Icon(Icons.people),
                                      padding: const EdgeInsets.only(right: 15),
                                      onPressed: () {
                                        String idCmp =
                                            snapshot.data[index]['id'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListEmployee(idC: idCmp)),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                            onTap: () {
                              String idCmp = snapshot.data[index]['id'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListAvis(idA: idCmp)),
                              );
                            },
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );
            } else {
              return Center(child: Text("hi ena list company wahdi"));
            }
          },
        ),
      ),
     // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
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

    AvisModel _avis;
    final TextEditingController commentController = TextEditingController();

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
