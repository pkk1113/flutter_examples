import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(home: App()));

class Item {
  String str;
  Item({this.str});
}

class Controller extends GetxController {
  static Controller get to => Get.find();
  RxList<Item> items = RxList<Item>();

  @override
  void onInit() {
    items
      ..add(Item(str: '감자'))
      ..add(Item(str: '냉이'))
      ..add(Item(str: '된장'))
      ..add(Item(str: '라면'))
      ..add(Item(str: '미역'));

    debounce(items, (_) => print('!!'), time: Duration(seconds: 2));
    super.onInit();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(Controller());
    String str;
    print('App!!');

    return Scaffold(
      appBar: AppBar(title: Text('테스트!')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.dialog(
              AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                contentPadding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
                content: SizedBox(
                  width: 0,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      TextField(
                        onChanged: (value) {
                          print(value);
                          return str = value;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('취소'))),
                          SizedBox(width: 5),
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    ctrl.items.add(Item(str: str));
                                    Get.back();
                                  },
                                  child: Text('확인'))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              barrierDismissible: true);
        },
      ),
      body: Obx(
        () => ReorderableListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10.0),
              key: Key('$index'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ctrl.items[index].str),
                  ReorderableDragStartListener(
                      child: const Icon(
                        Icons.drag_handle,
                        size: 30,
                      ),
                      index: index)
                ],
              ),
            );
          },
          itemCount: ctrl.items.length,
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = ctrl.items.removeAt(oldIndex);
            ctrl.items.insert(newIndex, item);
          },
        ),
      ),
    );
  }
}
