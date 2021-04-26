import 'package:flutter/material.dart';

class TestKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('테스트 Keyboard')),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: ListView(
          children: [
            Container(color: Colors.red[100], child: TextField()),
            Container(color: Colors.red[200], child: TextField()),
            Container(color: Colors.red[300], child: TextField()),
            Container(color: Colors.red[400], child: TextField()),
            Container(color: Colors.red[500], child: TextField()),
            Container(color: Colors.red[600], child: TextField()),
            Container(color: Colors.red[700], child: TextField()),
            Container(color: Colors.yellow[100], child: TextField()),
            Container(color: Colors.yellow[200], child: TextField()),
            Container(color: Colors.yellow[300], child: TextField()),
            Container(color: Colors.yellow[400], child: TextField()),
            Container(color: Colors.yellow[500], child: TextField()),
            Container(color: Colors.yellow[600], child: TextField()),
            Container(color: Colors.yellow[700], child: TextField()),
            Container(color: Colors.green[100], child: TextField()),
            Container(color: Colors.green[200], child: TextField()),
            Container(color: Colors.green[300], child: TextField()),
            Container(color: Colors.green[400], child: TextField()),
            Container(color: Colors.green[500], child: TextField()),
            Container(color: Colors.green[600], child: TextField()),
            Container(color: Colors.green[700], child: TextField()),
            Container(color: Colors.green[700], child: TextField()),
          ],
        ),
      ),
    );
  }
}
