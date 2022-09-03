import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

void main() async {
  try {
    // WidgetsFlutterBinding.ensureInitialized();
    // await FlutterConfig.loadEnvVariables();
    //if env error: add .env file in root folder & edit pubspec.yaml file
    await dotenv.load(fileName: CfgEnvironment.filename);
  } catch (e) {
    debugPrint("error: $e");
  }
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
      child: MaterialApp(
        title: 'Battery Alarm',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blue,
            secondary: Colors.amber,
            error: Colors.red,
          ),
        ),
        home: const TabsScreen(),
        routes: {
          RoutesConfig.tabScreen: (ctx) => const TabsScreen(),
          // RoutesConfig.placeDetailScreen: (ctx) => const PlaceDetailScreen(), //(example)
        },
      ),
    );
  }
}
