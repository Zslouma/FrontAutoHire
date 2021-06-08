import 'package:flutter/material.dart';
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/enums.dart';

import 'components/completeBody.dart';

class ProfileComplete extends StatelessWidget {
  static String routeName = "/profileComplete";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Filling With Resume"),
      ),
      body: completeBody(),
    );
  }
}
