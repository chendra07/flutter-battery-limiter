import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class SettingHiveModel {
  SettingHiveModel(
      {required this.enableAlarm,
      required this.limitMax,
      required this.limitMin});

  @HiveField(0)
  bool enableAlarm;

  @HiveField(1)
  int limitMax;

  @HiveField(2)
  int limitMin;
}
