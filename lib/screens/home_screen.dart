import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:provider/provider.dart';

//provider
import '../providers/setting_provider.dart';

//components
// import '../components/UI/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final battery = Battery();

  int batteryLevel = 100;
  BatteryState batteryState = BatteryState.unknown;
  Timer? timer;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

    listenBatteryLevel();
    listenBatteryState();
  }

  void listenBatteryState() =>
      subscription = battery.onBatteryStateChanged.listen((batteryState) {
        setState(() {
          this.batteryState = batteryState;
        });
      });

  void listenBatteryLevel() {
    updateBatteryLevel();
    // timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 15), (_) async {
      await updateBatteryLevel();
    });
  }

  Future updateBatteryLevel() async {
    final int batteryLevel = await battery.batteryLevel;
    setState(() {
      this.batteryLevel = batteryLevel;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context).loadAllSettings;
    // final PreferredSizeWidget appBar = CustomAppBar.adaptiveAppBar(
    //   "Add new place",
    //   [],
    // );

    Widget buildBatteryLevel(int level) {
      return Text(
        "$batteryLevel%",
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 46,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget buildBatteryState(
      BatteryState battery,
      Map<String, dynamic> batteryConfig,
    ) {
      const style = TextStyle(fontSize: 32, color: Colors.grey);
      const double size = 200;

      switch (battery) {
        case BatteryState.full:
          const color = Colors.green;
          return Column(
            children: const [
              Icon(
                Icons.battery_full,
                size: size,
                color: color,
              ),
              Text(
                "Full!",
                style: style,
              ),
            ],
          );
        case BatteryState.charging:
          const color = Colors.green;
          return Column(
            children: const [
              Icon(
                Icons.battery_charging_full,
                size: size,
                color: color,
              ),
              Text(
                "Charging...",
                style: style,
              ),
            ],
          );
        default:
          const color = Colors.orangeAccent;
          const alertColor = Colors.red;
          return Column(
            children: [
              Icon(
                Icons.battery_charging_full,
                size: size,
                color: batteryLevel > (batteryConfig["limitMin"] as int)
                    ? color
                    : alertColor,
              ),
              const Text(
                "Discharging...",
                style: style,
              ),
            ],
          );
      }
    }

    return Scaffold(
      // appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBatteryLevel(batteryLevel),
            buildBatteryState(batteryState, settings),
          ],
        ),
      ),
    );
  }
}
