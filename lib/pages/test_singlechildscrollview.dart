import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _TestSingleChildScrollerView extends GetxController {
  RxBool iconState = false.obs;

  Future<void> switchIconState() async {
    iconState.value = !iconState.value;
  }
}

class TestSingleChildScrollerView extends StatelessWidget {
  final controller = Get.put(_TestSingleChildScrollerView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test SingleChildScrollView',
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.switchIconState,
        child: Stack(
          children: [
            InkWell(
              onTap: () {},
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Obx(() => controller.iconState.value
                    ? Icon(Icons.accessibility, size: 100.0)
                    : Icon(Icons.accessibility_new, size: 100.0)),
              ),
            ),
            ListView(),
          ],
        ),
      ),
    );
  }
}
