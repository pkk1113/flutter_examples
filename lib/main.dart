import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(home: App()));

class Item {
  String str;
  Item({this.str});
}

class ItemWidget extends StatelessWidget {
  final Key key;
  final int index;
  final String str;
  final bool isLast;

  ItemWidget({this.index, this.str, this.isLast}) : key = Key('$index');

  @override
  Widget build(BuildContext context) {
    print(str);
    return Material(
      child: Container(
        key: key,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // child: Text(str),
              child: TextFormField(
                  key: Key(str),
                  initialValue: str,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  onFieldSubmitted: (value) {},
                  onEditingComplete: () {
                    return isLast ? Get.focusScope.unfocus() : Get.focusScope.nextFocus();
                  }),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTapDown: (_) => Get.focusScope.unfocus(),
              child: ReorderableDragStartListener(
                child: const Icon(
                  Icons.drag_handle,
                  size: 30,
                ),
                index: index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var items = [];
  TextEditingController textEditorController;

  @override
  void initState() {
    items
      ..add(Item(str: '감자'))
      ..add(Item(str: '냉이'))
      ..add(Item(str: '된장'))
      ..add(Item(str: '라면'))
      ..add(Item(str: '미역'));
    textEditorController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('app build');
    return Scaffold(
      appBar: AppBar(title: Text('테스트!')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: () {
                setState(() {
                  items[0] = Item(str: '고구마');
                });
              },
              child: Icon(Icons.change_history)),
          SizedBox(width: 10),
          FloatingActionButton(
              onPressed: () {
                setState(() {
                  items.removeLast();
                });
              },
              child: Icon(Icons.remove)),
          SizedBox(width: 10),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _showDialog(),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          Get.focusScope.unfocus();
        },
        child: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return ItemWidget(
              index: index,
              str: items[index].str,
              isLast: items.length - 1 == index,
            );
          },
          itemCount: items.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = items.removeAt(oldIndex);
              items.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }

  _showDialog() {
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
                controller: textEditorController,
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
                        textEditorController.clear();
                        Get.back();
                      },
                      child: Text('확인'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
