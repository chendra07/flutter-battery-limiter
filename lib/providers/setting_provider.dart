import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  Map<String, dynamic> settings = {
    "enableAlarm": true,
    "limitMax": 80,
    "limitMin": 30,
  };

  Map<String, dynamic> get loadAllSettings {
    return {...settings};
  }

  void updateNewSetting(Map<String, dynamic> newSetting) {
    settings = {...newSetting};
    notifyListeners();
  }
}
