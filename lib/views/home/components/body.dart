import 'package:flutter/material.dart';
import 'package:slouma_v1/views/home/ListOffres.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
              child: ListOffres(),
            )
          ],
        ));
  }
}
