import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item {
  String str;
  Color color;
  Item({
    this.str,
    this.color,
  });
}

class Controller extends GetxController {
  RxList<Item> items = RxList<Item>();

  @override
  void onInit() {
    items
      ..add(Item(str: '더하기', color: Colors.red[200]))
      ..add(Item(str: '빼기', color: Colors.blue[200]))
      ..add(Item(str: '곱하기', color: Colors.green[200]))
      ..add(Item(str: '나누기', color: Colors.yellow[200]));

    debounce(items, (_) => print('Changed!'), time: Duration(seconds: 2));
    super.onInit();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(title: Text('RxList 테스트')),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: ctrl.items.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                color: ctrl.items[index].color,
                child: Center(
                  child: Text(ctrl.items[index].str),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Center(
                  child: Text(
                '순서 바꾸기',
                textAlign: TextAlign.center,
              )),
              onPressed: () {
                final f = ctrl.items[0];
                ctrl.items.removeAt(0);
                ctrl.items.insert(ctrl.items.length, f);
              },
            ),
            SizedBox(width: 5),
            FloatingActionButton(
              child: Center(
                  child: Text(
                'Bad Case',
                textAlign: TextAlign.center,
              )),
              onPressed: () {
                // Bad
                ctrl.items[0].str = "안녕?";
                ctrl.items[0] = ctrl.items[0];
              },
            ),
            SizedBox(width: 5),
            FloatingActionButton(
              child: Center(
                  child: Text(
                'Good Case',
                textAlign: TextAlign.center,
              )),
              onPressed: () {
                // Good
                ctrl.items[0] = Item(str: '안녕하세요!', color: Colors.orange[100]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
