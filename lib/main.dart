import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appbar_widget_demo.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  static const _darkModeKey = 'isDarkMode';

  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode = (prefs.getBool(_darkModeKey) ?? false)
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  Future<void> _setDarkMode(bool isDarkMode) async {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppBar Demo',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: AppBarWidgetDemo(
        isDarkMode: _themeMode == ThemeMode.dark,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }
}
