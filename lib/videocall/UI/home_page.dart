import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'Dialogs/create_room.dart';
import 'Dialogs/join_room.dart';
import 'package:flutter/material.dart';
import '../Helpers/text_styles.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/videocall";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60, left: 30),
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("AutoHire VideoCall Side",
                    style: TextStyle(
                      color: Color(0xFFC51162),
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                    )),
                const SizedBox(height: 10),
                Text("Pour tous les candidats valide aprés l'envoi du CV",
                    style: TextStyle(
                      color: Color(0xFFC51162),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                top: 30,
              ),
              padding: const EdgeInsets.only(
                top: 30,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Center(
                  child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return CreateRoomDialog();
                              });
                        },
                        child: Row(
                          children: [
                            Flexible(
                                flex: 7,
                                child: Image.asset(
                                  "assets/images/create_meeting_vector.png",
                                  fit: BoxFit.fill,
                                )),
                            Flexible(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Creer un salon",
                                    style: largeTxtStyle.copyWith(
                                        color: const Color(0xFFC51162)),
                                  ),
                                  Text(
                                    "Creer un salon pour l'envoyer aux candidats",
                                    style: regularTxtStyle.copyWith(
                                        color: const Color(0xFF000000)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        margin: const EdgeInsets.all(20),
                        color: const Color(0xFFC51162)),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return JoinRoomDialog();
                              });
                        },
                        child: Row(
                          children: [
                            Flexible(
                                flex: 6,
                                child: Image.asset(
                                  "assets/images/join_meeting_vector.png",
                                  fit: BoxFit.fill,
                                )),
                            Flexible(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Rejoindre un salon",
                                    style: largeTxtStyle.copyWith(
                                        color: const Color(0xFFC51162)),
                                  ),
                                  Text(
                                    "Rejoindre un salon recu dans le message privé",
                                    style: regularTxtStyle.copyWith(
                                        color: const Color(0xFF000000)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
