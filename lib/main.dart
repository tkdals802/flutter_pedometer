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

  @override
  Widget build(BuildContext context) {
    //initState();
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               FutureBuilder<RxInt>(
                 future: pedometerController.getCurrentStep(),
                 builder: (context,snapshot){
                   if(snapshot.connectionState == ConnectionState.waiting){
                     return CircularProgressIndicator();
                   }else if(snapshot.hasError){
                     return Text('Error : ${snapshot.error}');
                   }else{
                     return Text('current Step${snapshot.data}');
                   }
                 },
               )

              //Obx(()=>Text('${pedometerController.getCurrentStep()}')

            ],
          ),
        ),
      ),
    );
  }
}
