import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  Map<String, dynamic> settings = {
    "enableAlarm": true,
    "limitMax": 80,
    "limitMin": 30,
  };

  Map<String, dynamic> get loadAllSettings {
    print("Hi!");
    return {...settings};
  }

  Future<void> updateNewSetting(Map<String, dynamic> newSetting) async {
    final persistsData = await SharedPreferences.getInstance();
    settings = {...newSetting};
    notifyListeners();
    try {
      final userData = jsonEncode({
        "enableAlarm": settings["enableAlarm"] as bool,
        "limitMax": settings["limitMax"] as int,
        "limitMin": settings["limitMin"] as int,
      });
      persistsData.setString('userData', userData);
    } catch (e) {
      debugPrint("Error: failed to save data | message: $e");
    }
  }

  Future<bool> loadSavedSetting() async {
    final persistData = await SharedPreferences.getInstance();
    if (!persistData.containsKey("userData")) {
      return false;
    }

    try {
      final extractedUserData =
          json.decode(persistData.getString("userData").toString())
              as Map<String, dynamic>;

      settings = {
        "enableAlarm": extractedUserData["enableAlarm"] as bool,
        "limitMax": extractedUserData["limitMax"] as int,
        "limitMin": extractedUserData["limitMin"] as int,
      };
    } catch (e) {
      debugPrint("Error: failed to load data | message: $e");
    }
    print("reach here");
    // notifyListeners();
    return true;
  }
}
