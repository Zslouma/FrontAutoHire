import 'package:flutter/material.dart';
import 'package:slouma_v1/videocall/UI/home_page.dart';
import 'routes.dart';
import 'theme.dart';
import 'package:slouma_v1/views/home/home.dart';
import 'views/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:slouma_v1/views/home/ListOffres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoHire',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: ListOffres.routeName,

      routes: routes,
    );
  }
}
