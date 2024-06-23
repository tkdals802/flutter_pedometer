import 'dart:async';

import 'package:pedometer/pedometer.dart';

class WalkService{
  late Stream<StepCount> _stepCountStream;

  int _currentSteps = 0;
  int _pastSteps = 0;
  int _totalSteps = 0;

  Future<int> getCurrentStep() {
    print('${_currentSteps}');
    return Future<int>.value(_currentSteps);
  }

  void updateStep(StepCount event) async{
    _totalSteps = event.steps;
    _currentSteps = _totalSteps - _pastSteps;
    //print('init ${_currentSteps},${_totalSteps}, ${_pastSteps}');
  }

  void resetStepTimer() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day, now.second+10);

    _pastSteps = _totalSteps;
    print('reset timer ${_totalSteps}, ${_currentSteps}, ${_pastSteps}');
  }

  void onStepCountError(error) {
    _currentSteps = 0;
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(updateStep).onError(onStepCountError);
  }

}