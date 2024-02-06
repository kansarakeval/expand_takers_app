import 'package:expand_takers_app/screen/dash/controller/dash_controller.dart';
import 'package:expand_takers_app/screen/graph/view/graph_Screen.dart';
import 'package:expand_takers_app/screen/home/view/home_Screen.dart';
import 'package:expand_takers_app/screen/setting/view/setting_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  List<Widget> screen = [
    const HomeScreen(),
    const GraphScreen(),
    const SettingScreen(),
  ];

  DashController controller = DashController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => PageView(
            controller: controller.pageController.value,
            onPageChanged: (value) {
              controller.screenIndex.value = value;
            },
            children: screen,
          ),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            selectedIndex: controller.screenIndex.value,
            onDestinationSelected: (value) {
              controller.pageController.value.animateToPage(value,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn);
              controller.screenIndex.value = value;
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.auto_graph), label: "Graph"),
              NavigationDestination(
                  icon: Icon(Icons.settings_outlined), label: "Setting"),
            ],
            animationDuration: const Duration(microseconds: 1000),
          ),
        ),
      ),
    );
  }
}
