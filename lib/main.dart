import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:slouma_v1/views/home/ListCompany.dart';
import 'package:slouma_v1/views/login_success/login_success_screen.dart';
import 'routes.dart';
import 'theme.dart';
import 'views/splash/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  dynamic email = FlutterSession().get('email');
  if (email != '') {
    runApp(MyApp2());
  } else
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
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("hneeeeeeeeeeeee");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoHire',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: ListCompany .routeName,
      routes: routes,
    );
  }
}
