import 'package:flutter/material.dart';
import 'package:uneva/noteDetail.dart';

import 'notelist.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Colors.green,
      primaryColor: Colors.green,
    ),
    debugShowCheckedModeBanner: false,
    title: "UNEVA",
    home: notelist(),
  ));
}
