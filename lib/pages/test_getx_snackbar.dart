import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestGetxSnackbarController extends GetxController with SingleGetTickerProviderMixin {
  static TestGetxSnackbarController get to => Get.find();
  static const _keeyDurationMilliseconds = 3000;
  static const _animatedDurationMilliseconds = 300;
  static const _durationMilliseconds =
      _keeyDurationMilliseconds + 2 * _animatedDurationMilliseconds;
  static const Duration _duration = Duration(milliseconds: _durationMilliseconds);

  Animation _animation;
  AnimationController _animationController;

  RxBool showMessaging = false.obs;
  RxString title = ''.obs;
  RxString body = ''.obs;
  RxDouble animationValue = 0.0.obs;
  double get opacity => animationValue.value < 0.1
      ? animationValue.value * 10.0
      : animationValue.value > 0.9
          ? (1.0 - animationValue.value) * 10.0
          : 1.0;
  double get offsetY => animationValue.value < 0.1
      ? animationValue.value * 100
      : animationValue.value > 0.9
          ? (1.0 - animationValue.value) * 100
          : 10.0;

  Future<void> showSnackbar(
    String title,
    String body,
  ) async {
    _animationController.reset();
    _animationController.forward();
    showMessaging.value = true;
    this.title.value = title;
    this.body.value = body;
  }

  @override
  void onInit() {
    _animationController = AnimationController(vsync: this, duration: _duration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        animationValue.value = _animation.value;
      });
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

class TestGetxSnackbar extends GetView<TestGetxSnackbarController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text('Test Snackbar'), centerTitle: true),
          body: Container(
            child: Center(
              child: FittedBox(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => controller.showSnackbar('제목', '내용1'), child: Text('스낵바1')),
                    ElevatedButton(
                        onPressed: () => controller.showSnackbar('제목', '내용2\n내용2'),
                        child: Text('스낵바2')),
                    ElevatedButton(
                        onPressed: () => controller.showSnackbar('제목', '내용3\n내용3\n내용3'),
                        child: Text('스낵바3')),
                    ElevatedButton(
                        onPressed: () => controller.showSnackbar('제목', '내용4\n내용4\n내용4\n내용4'),
                        child: Text('스낵바4')),
                    ElevatedButton(
                        onPressed: () => controller.showSnackbar('제목', '내용5\n내용5\n내용5\n내용5\n내용5'),
                        child: Text('스낵바5')),
                    ElevatedButton(onPressed: back, child: Text('뒤로 가기')),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() => controller.showMessaging.value
            ? Row(
                children: [
                  Spacer(),
                  Obx(() => Opacity(
                        opacity: controller.opacity,
                        child: Transform.translate(
                          offset: Offset(0, controller.offsetY),
                          child: Draggable(
                            axis: Axis.vertical,
                            feedback: _buildSnackbar(),
                            child: GestureDetector(
                                onTap: () => print('hello~'), child: _buildSnackbar()),
                            onDragStarted: () => controller.showMessaging.value = false,
                          ),
                        ),
                      )),
                  Spacer(),
                ],
              )
            : SizedBox()),
      ],
    );
  }

  Container _buildSnackbar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Color(0xffF4F4F4),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 2.0, offset: Offset(0, 2))]),
      margin: EdgeInsets.only(top: 25.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      width: 300.0,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Obx(() => Text(
                  controller.title.value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    height: 22.0 / 20.0,
                    decoration: TextDecoration.none,
                  ),
                )),
            SizedBox(height: 10.0),
            Obx(() => Text(
                  controller.body.value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    height: 20.0 / 16.0,
                    decoration: TextDecoration.none,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void back() {
    Get.back();
  }
}
