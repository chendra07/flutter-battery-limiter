import 'package:flutter/material.dart';

//screens
import '../screens/home_screen.dart';
import '../screens/setting_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      {
        'page': const HomeScreen(),
        'title': 'Battery Status',
        'icon': Icons.battery_full,
        'label': 'Battery',
        'backgroundColor': Colors.blue,
      },
      {
        'page': const SettingsScreen(),
        'title': 'Settings',
        'icon': Icons.settings,
        'label': 'Settings',
        'backgroundColor': Colors.blue,
      },
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  BottomNavigationBarItem _bottomTabNavBuilder({
    required BuildContext context,
    required String label,
    required Icon icon,
    MaterialColor? backgroundColor,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      icon: icon,
      label: label.isEmpty ? "[Unknown label]" : label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
        ),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: _pages.map((element) {
          return _bottomTabNavBuilder(
            context: context,
            backgroundColor: element['backgroundColor'] as MaterialColor,
            icon: Icon(element['icon'] as IconData),
            label: element['label'] as String,
          );
        }).toList(),
      ),
    );
  }
}
