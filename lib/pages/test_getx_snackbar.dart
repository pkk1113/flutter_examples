import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestGetxSnackbarController extends GetxController with SingleGetTickerProviderMixin {
  static TestGetxSnackbarController get to => Get.find();
  static const _keeyDurationMilliseconds = 3000.0;
  static const _animatedDurationMilliseconds = 300.0;
  static const _durationMilliseconds =
      _keeyDurationMilliseconds + 2 * _animatedDurationMilliseconds;
  static final Duration _duration = Duration(milliseconds: _durationMilliseconds.toInt());

  Animation _animation;
  AnimationController _animationController;

  RxBool showMessaging = false.obs;
  RxString title = ''.obs;
  RxString body = ''.obs;
  RxDouble animationValue = 0.0.obs;
  RxDouble dragY = 0.0.obs;
  double get _curve => animationValue.value < _animatedDurationMilliseconds
      ? animationValue.value / _animatedDurationMilliseconds
      : animationValue.value > (_durationMilliseconds - _animatedDurationMilliseconds)
          ? (_durationMilliseconds - animationValue.value) / _animatedDurationMilliseconds
          : 1.0;
  double get opacity => _curve * 1.0;
  double get offsetY => _curve * 30.0;

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
    _animation = Tween<double>(begin: 0.0, end: _durationMilliseconds).animate(_animationController)
      ..addListener(() {
        animationValue.value = _animation.value;
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.forward:
          case AnimationStatus.reverse:
          case AnimationStatus.dismissed:
            break;
          case AnimationStatus.completed:
            dragY.value = 0.0;
            break;
        }
      });
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  void stop() {
    _animationController.stop();
  }

  void close() {
    showMessaging.value = false;
    _animationController.reset();
    dragY.value = 0.0;
  }

  void enter() {
    print('~~~');
    close();
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
                  Obx(() => Text('${controller.animationValue.toInt()}')),
                ],
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
                          offset: Offset(0, controller.offsetY + controller.dragY.value),
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: controller.enter,
                              onTapDown: (details) {
                                controller.stop();
                              },
                              onVerticalDragStart: (details) {
                                controller.stop();
                              },
                              onVerticalDragUpdate: (details) {
                                controller.dragY.value += details.delta.dy;
                                if (controller.dragY.value > 0.0) controller.dragY.value = 0.0;
                              },
                              onVerticalDragEnd: (details) {
                                if (controller.dragY.value > 10.0)
                                  controller.close();
                                else
                                  controller.enter();
                              },
                              child: _buildSnackbar()),
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
