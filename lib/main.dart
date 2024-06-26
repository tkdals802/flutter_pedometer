import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice4/pedometer.dart';
import 'package:practice4/pedometer_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PedometerController pedometerController = Get.put(PedometerController());

  void init(){
    pedometerController
  }

  @override
  Widget build(BuildContext context) {
    init();
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(pedometerController.getStep())),

              //Obx(()=>Text('${pedometerController.getCurrentStep()}')

            ],
          ),
        ),
      ),
    );
  }
}
