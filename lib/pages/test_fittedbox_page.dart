import 'package:flutter/material.dart';

class TestFittedBoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('테스트 FittedBox')),
      body: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.insert_emoticon_outlined),
                    Text('A'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_emoticon_outlined),
                    Text('AAAAAAAAAAAAAAAAA'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_emoticon_outlined),
                    Text('AAAAAA'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_emoticon_outlined),
                    Text('AA'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_emoticon_outlined),
                    Text('A'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_emoticon_outlined),
                    Text('AAAAA'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
