import 'package:flutter/material.dart';

class TestMixinPage extends StatefulWidget {
  @override
  _TestMixinPageState createState() => _TestMixinPageState();
}

class _TestMixinPageState extends State<TestMixinPage> {
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: 'empty');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('테스트 Mixin')),
      floatingActionButton: FloatingActionButton(
        onPressed: _main,
        child: Text('main()'),
      ),
      body: Container(
        child: Center(
          child: Text(textEditingController.text),
        ),
      ),
    );
  }

  Future<void> _main() async {
    final some = _Some();
    some.onInit();
  }
}

abstract class Controller {
  void onInit() => print('onInit');
}

mixin MixinA on Controller {
  @override
  void onInit() {
    print('mixin a');
    super.onInit();
  }
}

mixin MixinB on Controller {
  @override
  void onInit() {
    print('mixin b');
    super.onInit();
  }
}

mixin MixinC on Controller {
  @override
  void onInit() {
    super.onInit();
    print('mixin c');
  }
}

class _Some extends Controller with MixinA, MixinC, MixinB {
  @override
  void onInit() {
    print('some init');
    super.onInit();
  }
}
