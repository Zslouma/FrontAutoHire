import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:multipart_request/multipart_request.dart';
import 'package:slouma_v1/utils/utils.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key key,
  }) : super(key: key);
  String imagePath = "";

  void uploadImage() {
    var request = MultipartRequest();

    request.setUrl(Utils.url2 + "/uploadImage");
    request.addFile("file", imagePath);
    request.addField("name", "aymen");
    Response response = request.send();

    response.onError = () {
      print("Error");
    };

    response.onComplete = (response) {
      print(response);
    };

    response.progress.listen((int progress) {
      print("progress from response object " + progress.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      final galleryFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      imagePath = galleryFile.path;
      uploadImage();
    }

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/aymen.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  imageSelectorGallery();
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
