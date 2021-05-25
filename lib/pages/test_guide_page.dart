import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestGuidePageController extends GetxController {
  GlobalKey notificationButtonGlbalKey = GlobalKey();
  GlobalKey addFloatingButtonGlbalKey = GlobalKey();
  GlobalKey bottomNavigationGlbalKey = GlobalKey();
  GlobalKey cardGlbalKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
  }
}

class TestGuidePage extends GetView<TestGuidePageController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text('테스트'), centerTitle: true, actions: [
            Container(
                margin: EdgeInsets.only(right: 10.0),
                width: 30.0,
                child: Center(
                    child: Icon(Icons.notifications, key: controller.notificationButtonGlbalKey)))
          ]),
          floatingActionButton: FloatingActionButton(
              key: controller.addFloatingButtonGlbalKey,
              child: Icon(Icons.add_ic_call_sharp),
              onPressed: () {}),
          bottomNavigationBar: BottomNavigationBar(
            key: controller.bottomNavigationGlbalKey,
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '유저 정보'),
              BottomNavigationBarItem(icon: Icon(Icons.mail), label: '메일')
            ],
          ),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildCard('개인용 휴대폰', key: controller.cardGlbalKey)),
              Padding(padding: const EdgeInsets.all(8.0), child: _buildCard('업무용 휴대폰1')),
              Padding(padding: const EdgeInsets.all(8.0), child: _buildCard('업무용 휴대폰2')),
            ],
          ),
        ),
        _GuideSheet(controller: controller),
      ],
    );
  }

  Widget _buildCard(String label, {Key key}) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2.0, offset: Offset(0, 1))],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label), Icon(Icons.menu)]),
          Icon(Icons.phone_android, size: 100.0),
        ],
      ),
    );
  }
}

class _GuideSheet extends StatelessWidget {
  final TestGuidePageController controller;
  _GuideSheet({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
          _buildRect(controller.addFloatingButtonGlbalKey),
          _buildRect(controller.bottomNavigationGlbalKey),
          _buildRect(controller.cardGlbalKey),
          _buildRect(controller.notificationButtonGlbalKey),
        ],
      ),
    );
  }

  Widget _buildRect(Key key) {
    return Positioned(
      left: _getPosition(key).dx,
      top: _getPosition(key).dy,
      child: Container(
        width: _getSize(key).width,
        height: _getSize(key).height,
        decoration: BoxDecoration(border: Border.all(color: Colors.yellow, width: 2.0)),
      ),
    );
  }
}

Offset _getPosition(GlobalKey globalKey) {
  final RenderBox renderBox = globalKey.currentContext.findRenderObject();
  return renderBox.localToGlobal(Offset.zero);
}

Size _getSize(GlobalKey globalKey) {
  final RenderBox renderBox = globalKey.currentContext.findRenderObject();
  return renderBox.size;
}
