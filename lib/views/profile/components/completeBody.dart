import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multipart_request/multipart_request.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/profile/ProfileDetailsScreen.dart';
import 'package:slouma_v1/views/profile/components/uploadingscreen.dart';

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

// ignore: camel_case_types
class completeBody extends StatelessWidget {
  int index = 1;
  String tit = 'Upload File';
  String sub = 'Browse and chose the resume you want to upload.';
  String filepath = '';
  void uploadResume() {
    var request = MultipartRequest();

    request.setUrl(Utils.url2 + "/parseCVflutter");
    request.addFile("upl2", filepath);
    request.addField("username", "aymen");
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
    void getFilePath() async {
      filepath = await FilePicker.getFilePath(
          type: FileType.CUSTOM, fileExtension: 'pdf');
      if (filepath != '') {
        print("File path: " + filepath);
        uploadResume();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadScreen(0, '2', tit, sub)));

        await new Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, ProfileDetailsScreen.routeName);

        return;
      } else {
        print("Error while picking the file");
      }
    }

    return Scaffold(
        floatingActionButton: index == 1
            ? FloatingActionButton(
                onPressed: () {
                  getFilePath();
                },
                backgroundColor: Colors.pink,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
        floatingActionButtonLocation:
            index == 1 ? FloatingActionButtonLocation.centerFloat : null,
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/upload.png"))),
            ),
            SizedBox(
              height: 60.0,
            ),
            Text(
              tit,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.5,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                sub,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.5,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ));
  }
}
