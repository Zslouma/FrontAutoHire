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
      backgroundColor: Colors.black,
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
                        return Card(
                          elevation: 10,
                          child: ListTile(
                            selectedTileColor: Colors.black,
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(snapshot.data[index]['question'],
                                style: TextStyle(color: Colors.white)),
                            tileColor: Color(0xFFC51162),
                            subtitle: Text(
                                snapshot.data[index]['reponse'] +
                                    snapshot.data[index]['sujet'],
                                style: TextStyle(color: Colors.white)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => confirtDelete(
                                  snapshot.data[index]['id'], context),
                            ),
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
              return Center(child: Text("hi ena list test wahdi"));
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
