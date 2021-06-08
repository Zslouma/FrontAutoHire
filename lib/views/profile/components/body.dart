import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:slouma_v1/views/chatbot_help/chatbot.dart';
import 'package:slouma_v1/views/profile/profile_complete.dart';
import 'package:slouma_v1/views/profile/profile_validation.dart';
import 'package:slouma_v1/views/splash/splash_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:slouma_v1/views/profile/ProfileDetailsScreen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, ProfileDetailsScreen.routeName)},
          ),
          ProfileMenu(
            text: "Upload Your Resume",
            icon: "assets/icons/Flash Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, ProfileComplete.routeName)},
          ),
          ProfileMenu(
            text: "Verify My Account",
            icon: "assets/icons/Check mark rounde.svg",
            press: () =>
                {Navigator.pushNamed(context, ProfileValidation.routeName)},
          ),
          ProfileMenu(
            text: "Chat Bot",
            icon: "assets/icons/Settings.svg",
            press: () => {Navigator.pushNamed(context, Chatbot.routeName)},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () => {
              FlutterSession().set('email', ''),
              Navigator.pushNamed(context, SplashScreen.routeName)
            },
          ),
        ],
      ),
    );
  }
}
