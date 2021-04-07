import 'package:flutter/material.dart';
import 'package:slouma_v1/views/splash/components/body.dart';
import 'package:slouma_v1/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/WelcomeScreen.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Center(
            child: Body(),
          )
        ],
      ),
    );
  }
}
