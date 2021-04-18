import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slouma_v1/videocall/pages/index.dart';
import 'package:slouma_v1/views/chatbot_help/chatbot.dart';
import 'package:slouma_v1/views/home/ListCompany.dart';
import 'package:slouma_v1/views/home/ListOffres.dart';
import 'package:slouma_v1/views/home/listTest.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Heart Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, ListCompany.routeName),
              ),
              IconButton(
                icon: Icon(
                  Icons.work_outline_outlined,
                  color: MenuState.favourite == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, ListOffres.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  color: MenuState.jobs == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, IndexPage.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Flash Icon.svg",
                  color: MenuState.message == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, ListTest.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, Chatbot.routeName),
              ),
            ],
          )),
    );
  }
}
