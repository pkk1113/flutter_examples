import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/test_appbar.dart';
import 'package:flutter_application_1/pages/test_fittedbox_page.dart';
import 'package:flutter_application_1/pages/test_guide_page.dart';
import 'package:flutter_application_1/pages/test_keyboard.dart';
import 'package:flutter_application_1/pages/test_mixin_page.dart';
import 'package:flutter_application_1/pages/test_singlechildscrollview.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(home: Main()));

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Examples')),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: ListView(
          children: [
            _buildButton(TestFittedBoxPage()),
            _buildButton(TestMixinPage()),
            _buildButton(TestKeyboard()),
            _buildButton(TestSingleChildScrollerView()),
            _buildButton(TestAppBarPage()),
            _buildButton(TestGuidePage(),
                binding: BindingsBuilder.put(() => TestGuidePageController())),
          ],
        ),
      ),
    );
  }

  _buildButton(Widget page, {Bindings binding}) {
    return OutlinedButton(
      onPressed: () => Get.to(() => page, transition: Transition.rightToLeft, binding: binding),
      child: Text(page.toStringShort()),
    );
  }
}
