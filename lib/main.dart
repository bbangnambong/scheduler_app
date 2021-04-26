import 'package:flutter/material.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/root_app.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "스케쥴러",
    home: RootApp(),
  ));
  DBhelper().initDB();
}
