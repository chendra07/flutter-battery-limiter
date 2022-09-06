import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_background/flutter_background.dart';
// import 'package:flutter_config/flutter_config.dart';

//routes
import 'routes/routes_config.dart';
// import 'routes/custom_route.dart';

//cfg
import './utils/cfg_environment.dart'; //Note: don't forget to add .env in pubspec.yaml file

//provider
import './providers/setting_provider.dart';

//screens
import './screens/tab_screen.dart';

//components
import './components/UI/loading_animation.dart';

void main() async {
  AwesomeNotifications().initialize(
    "resource://drawable/app_icon",
    [
      NotificationChannel(
        channelGroupKey: 'battery_alert_group',
        channelKey: 'battery_alert',
        channelName: 'Battery Alert',
        channelDescription: 'Check battery condition',
        ledColor: Colors.white,
        enableVibration: true,
        playSound: true,
        channelShowBadge: true,
        importance: NotificationImportance.Max,
        // soundSource:
      ),
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupkey: 'battery_alert_group',
        channelGroupName: 'Battery Alert',
      ),
    ],
    debug: true,
  );
  try {
    // WidgetsFlutterBinding.ensureInitialized();
    // await FlutterConfig.loadEnvVariables();
    await dotenv.load(fileName: CfgEnvironment.filename);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
            .requestPermissionToSendNotifications(permissions: [
          NotificationPermission.Alert,
          NotificationPermission.Sound,
          NotificationPermission.Badge,
          NotificationPermission.Vibration,
          NotificationPermission.Light,
        ]);
      }
    });
  } catch (e) {
    debugPrint("error: $e");
  }
  print("Kirb here");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider(),
          ),
        ],
        child: Consumer<SettingsProvider>(
          builder: (context, settings, _) => MaterialApp(
            title: 'Battery Alarm',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.blue,
                secondary: Colors.amber,
                error: Colors.red,
              ),
            ),
            home: FutureBuilder(
              future: settings.loadSavedSetting(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Scaffold(
                          body: Center(
                            child: LoadingAnimation.adaptive(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : const TabsScreen(),
            ),
            routes: {
              RoutesConfig.tabScreen: (ctx) => const TabsScreen(),
              // RoutesConfig.placeDetailScreen: (ctx) => const PlaceDetailScreen(), //(example)
            },
          ),
        ));
  }
}
