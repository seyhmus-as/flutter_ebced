import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EbcedLetter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EbcedLetterState();
  }
}

class _EbcedLetterState extends State {
  var backgroundColor = Colors.green;
  var textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text("Ebced Listesi"),
          actions: <Widget>[
          ],
        ),
        body: Image.asset(
          'assets/ebced_tablo.jpg',
          fit: BoxFit.cover
        ),
      );
  }
}