import 'package:flutter/material.dart';

class TestAppBarPage extends StatefulWidget {
  @override
  _TestAppBarPageState createState() => _TestAppBarPageState();
}

class _TestAppBarPageState extends State<TestAppBarPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text('$count'),
        title: Text('Text AppBar leading'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}
