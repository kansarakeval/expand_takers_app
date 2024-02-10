import 'package:expand_takers_app/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  HomeController controller=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Graph",
          ),
          centerTitle: true,
        ),
        body: Center(
            child: SfCircularChart(
          title: const ChartTitle(text: "IncomeExpense"),
          legend: const Legend(isVisible: true),
          series: <CircularSeries>[
            DoughnutSeries<Map, String>(
              dataLabelSettings: const DataLabelSettings(isVisible: true,textStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
              dataSource: [
                {"amount": controller.totalIncome.value, "title": "Income", "color": Colors.green},
                {"amount": controller.totalExpense.value, "title": "Expense", "color": Colors.red},
              ],
              pointColorMapper: (datum, index) => datum['color'],
              xValueMapper: (datum, index) {
                return datum['title'];
              },
              yValueMapper: (datum, index) {
                return datum['amount'];
              },
            )

          ],
        )),
      ),
    );
  }
}
