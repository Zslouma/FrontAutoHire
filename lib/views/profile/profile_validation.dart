import 'package:flutter/material.dart';
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/enums.dart';

import 'components/completeBody.dart';
import 'components/validationBody.dart';

class ProfileValidation extends StatelessWidget {
  static String routeName = "/profileValidation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Validation"),
      ),
      body: validationBody(),
    );
  }
}
