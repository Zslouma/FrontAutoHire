import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/home/ListAvis.dart';

import '../../enums.dart';
import 'ListEvaluation.dart';

class ListCandidats extends StatelessWidget {
  final String idC;
  String idEmp;
  ListCandidats({Key key, this.idC}) : super(key: key);
  getCandidats() async {
    var res = await http.get(Uri.http(Utils.url, "/user/"));

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
          future: getCandidats(),
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
                                  String idCmp = snapshot.data[index]['id'];

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListEvaluation(idC: idCmp)),
                                  );
                                },
                              ),
                            ),
                            onTap: () {},
                          ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListAvis()));
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
