import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchInList extends StatefulWidget {
  @override
  _SearchInListState createState() => _SearchInListState();
}

class _SearchInListState extends State<SearchInList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            CupertinoSearchTextField(
              backgroundColor: HexColor("f08080").withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
