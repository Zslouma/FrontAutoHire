import 'package:flutter/widgets.dart';
import 'package:slouma_v1/videocall/pages/index.dart';
import 'package:slouma_v1/views/chatbot_help/chatbot.dart';
import 'package:slouma_v1/views/detail_offre/detail_offre.dart';
import 'package:slouma_v1/views/forgot_password/forgot_password_screen.dart';
import 'package:slouma_v1/views/home/ListCompany.dart';
import 'package:slouma_v1/views/home/ListOffres.dart';
import 'package:slouma_v1/views/home/home.dart';
import 'package:slouma_v1/views/home/listCandidature.dart';
import 'package:slouma_v1/views/home/listTest.dart';
import 'package:slouma_v1/views/login_success/login_success_screen.dart';
import 'package:slouma_v1/views/profile/ProfileDetailsScreen.dart';
import 'package:slouma_v1/views/profile/profile_complete.dart';
import 'package:slouma_v1/views/profile/profile_screen.dart';
import 'package:slouma_v1/views/profile/profile_validation.dart';
import 'package:slouma_v1/views/sign_in/sign_in_screen.dart';
import 'package:slouma_v1/views/splash/splash_screen.dart';

import 'views/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ListCompany.routeName: (context) => ListCompany(),
  ListTest.routeName: (context) => ListTest(),
  ListCandidature.routeName: (context) => ListCandidature(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ListOffres.routeName: (context) => ListOffres(),
  DetailOffre.routeName: (context) => DetailOffre(),
  IndexPage.routeName: (context) => IndexPage(),
  Chatbot.routeName: (context) => Chatbot(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProfileDetailsScreen.routeName: (context) => ProfileDetailsScreen(),
  ProfileComplete.routeName: (context) => ProfileComplete(),
  ProfileValidation.routeName: (context) => ProfileValidation(),
  /*CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),

  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),*/
};
