import '../../Helpers/text_styles.dart';
import '../../Helpers/utils.dart';
import '../../UI/videocall_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinRoomDialog extends StatelessWidget {
  final TextEditingController roomTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 20),
      title: Text("Join Room"),
      content: ListView(
        shrinkWrap: true,
        children: [
          Image.asset(
            'assets/images/room_join_vector.png',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: roomTxtController,
            decoration: InputDecoration(
                hintText: "Enter room id to join",
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xFFC51162), width: 2)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xFFC51162), width: 2))),
            style: regularTxtStyle.copyWith(
                color: const Color(0xFFC51162), fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () async {
              if (roomTxtController.text.isNotEmpty) {
                bool isPermissionGranted =
                    await handlePermissionsForCall(context);
                if (isPermissionGranted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoCallScreen(
                                channelName: roomTxtController.text,
                              )));
                } else {
                  Get.snackbar("Failed", "Enter Room-Id to Join.",
                      backgroundColor: Colors.white,
                      colorText: Color(0xFF1A1E78),
                      snackPosition: SnackPosition.BOTTOM);
                }
              } else {
                Get.snackbar(
                    "Failed", "Microphone Permission Required for Video Call.",
                    backgroundColor: Colors.white,
                    colorText: Color(0xFF1A1E78),
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_forward, color: Colors.white),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Join Room",
                  style: regularTxtStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
