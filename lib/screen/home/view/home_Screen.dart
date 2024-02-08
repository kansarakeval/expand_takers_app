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
              return InkWell(
                onTap: () {
                  Get.toNamed('detail', arguments: controller.incomeExpenseList[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1)]
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.incomeExpenseList[index].title}",
                            style:
                                const TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "${controller.incomeExpenseList[index].date}",
                            style:
                                const TextStyle(fontSize: 15,color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.incomeExpenseList[index].amount}",
                            style:
                                TextStyle(color: controller.incomeExpenseList[index].status=="0"?Colors.green:Colors.red,fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "${controller.incomeExpenseList[index].time}",
                            style:
                                TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
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
