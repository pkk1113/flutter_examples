import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item {
  String str;
  Color color;
  Item({this.str, this.color});
}

class Items {
  List<Item> items = [];
  Items({this.items});
}

class Controller extends GetxController {
  Rx<Items> items;

  @override
  void onInit() {
    items = Items(items: [
      Item(str: '감자', color: Colors.red[200]),
      Item(str: '고구마', color: Colors.blue[200]),
      Item(str: '딸기', color: Colors.green[200]),
      Item(str: '포도', color: Colors.yellow[200]),
    ]).obs;

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
            itemCount: ctrl.items.value.items.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                color: ctrl.items.value.items[index].color,
                child: Center(
                  child: Text(ctrl.items.value.items[index].str),
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
                ctrl.items.update((val) {
                  final v = val.items[0];
                  val.items.remove(v);
                  val.items.add(v);
                });
              },
            ),
            SizedBox(width: 5),
            FloatingActionButton(
              child: Center(
                  child: Text(
                '부분 바꾸기',
                textAlign: TextAlign.center,
              )),
              onPressed: () {
                ctrl.items.update((val) {
                  final v = val.items[0];
                  v.color = Colors.orange[100];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
