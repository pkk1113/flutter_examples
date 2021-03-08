import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("1 - StatefulWidget::createState()");
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = "hello";
  Color color = Colors.red[400];

  @override
  void initState() {
    super.initState();

    print("2 -  State::initState()");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("3 -  State::didChangeDependencies()");
  }

  @override
  Widget build(BuildContext context) {
    print("4 -  State::build()");
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        darkTheme: ThemeData.light(),
        home: Scaffold(
            body: Center(
                child: ElevatedButton(
                    child: Text("$test"),
                    onPressed: () {
                      if (test == "hello") {
                        setState(() {
                          test = "world";
                          color = Colors.amber[700];
                        });
                      } else {
                        setState(() {
                          test = "hello";
                          color = Colors.red[400];
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: this.color, minimumSize: Size(300, 300))))));
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("5 -  didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate()");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose()");
  }
}
