import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkService{
  late Stream<StepCount> _stepCountStream;

  static final String KEY = 'pastSteps';

  int _currentSteps = 0;
  int _pastSteps = 0;
  int _totalSteps = 0;

  Future<int> getCurrentStep() {
    print('${_currentSteps}');
    // return _currentSteps;
    return Future<int>.value(_currentSteps);
  }

  void updateStep(StepCount event) async{
    SharedPreferences pref = await SharedPreferences.getInstance();

    _totalSteps = event.steps;

    int? value = pref.getInt(KEY);

    if(value==null){
      _pastSteps = _totalSteps;
      pref.setInt(KEY,_totalSteps);
    }else{
      _pastSteps = value;
      print('value ${value}');
    }

    _currentSteps = _totalSteps - _pastSteps;
    print('init ${_currentSteps},${_totalSteps}, ${_pastSteps}');
  }

  void resetStepTimer() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _pastSteps = _totalSteps;
    pref.setInt(KEY,_totalSteps);
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