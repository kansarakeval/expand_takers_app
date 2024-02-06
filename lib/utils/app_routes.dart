import 'package:expand_takers_app/screen/dash/view/dash_screen.dart';
import 'package:expand_takers_app/screen/graph/view/graph_Screen.dart';
import 'package:expand_takers_app/screen/home/view/home_Screen.dart';
import 'package:expand_takers_app/screen/income/view/income_screen.dart';
import 'package:expand_takers_app/screen/setting/view/setting_Screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> app_routes = {
  '/': (context) => const DashScreen(),
  'Home': (context) => const HomeScreen(),
  'graph': (context) => const GraphScreen(),
  'setting': (context) => const SettingScreen(),
  'income': (context) => const IncomeScreen(),
};
