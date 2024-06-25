import 'dart:async';

import 'package:get/get.dart';
import 'package:practice4/pedometer.dart';

class PedometerController extends GetxController{
  late final WalkService walkService = WalkService();
  RxInt _currentStep = 0.obs;

  @override
  void onInit(){
    super.onInit();
    print('init');
    walkService.initPlatformState();
    Timer.periodic(const Duration(seconds: 10), (t){

      walkService.resetStepTimer();
    });
    Timer.periodic(const Duration(seconds: 1), (t){
      getCurrentStep().then((step){
        _currentStep.value = step;
      });
    });
  }

  Future<int> getCurrentStep() async {
    _currentStep.value = await walkService.getCurrentStep();
    return _currentStep.value;
  }

  String getStep() {
    return _currentStep.value.toString();
  }


}