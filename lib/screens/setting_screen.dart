import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../providers/setting_provider.dart';

//components
// import '../components/UI/app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enableAlarm = true;
  double _currentMaxLimitValue = 80;
  double _currentMinLimitValue = 20;
  bool _initialLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialLoad) {
      final settings = Provider.of<SettingsProvider>(context).loadAllSettings;
      setState(() {
        _enableAlarm = settings["enableAlarm"] as bool;
        _currentMaxLimitValue = (settings["limitMax"] as int).toDouble();
        _currentMinLimitValue = (settings["limitMin"] as int).toDouble();
        _initialLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    const defaultStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Scaffold(
      // appBar: appBar,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.5,
                  // width: double.infinity,
                  child: Switch(
                    value: _enableAlarm,
                    onChanged: ((value) {
                      setState(() {
                        _enableAlarm = value;
                      });
                    }),
                  ),
                ),
                const SizedBox(width: 25),
                const Text(
                  "Enable Alarm",
                  style: defaultStyle,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Max Battery Percentage: ",
              style: defaultStyle,
            ),
            Slider(
              value: _currentMaxLimitValue,
              max: 100,
              min: 60,
              divisions: 8,
              label: _currentMaxLimitValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentMaxLimitValue = value;
                });
              },
            ),
            const Text(
              "Min Battery Percentage: ",
              style: defaultStyle,
            ),
            Slider(
              value: _currentMinLimitValue,
              max: 50,
              min: 10,
              divisions: 8,
              label: _currentMinLimitValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentMinLimitValue = value;
                });
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  onPressed: () {
                    settings.updateNewSetting({
                      "enableAlarm": _enableAlarm,
                      "limitMax": _currentMaxLimitValue.toInt(),
                      "limitMin": _currentMinLimitValue.toInt(),
                    });
                  },
                ),
              ],
            ),
            Text((settings.loadAllSettings).toString())
          ],
        ),
      ),
    );
  }
}
