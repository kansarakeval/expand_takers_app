import 'package:expand_takers_app/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('category');
              },
              icon: const Icon(Icons.category),
            ),
          ],
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.incomeExpenseList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
                child: Row(
                  children: [
                    Text(
                      "${controller.incomeExpenseList[index].title}",
                      style:
                          const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "${controller.incomeExpenseList[index].amount}",
                      style:
                          TextStyle(color: controller.incomeExpenseList[index].status=="0"?Colors.green:Colors.red,fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed("income");
          },
        ),
      ),
    );
  }
}
