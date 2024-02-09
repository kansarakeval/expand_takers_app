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
  //controller
  TextEditingController txtsearch = TextEditingController();

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
                showFiletrDialog();
              },
              icon: const Icon(Icons.filter_list),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('category');
              },
              icon: const Icon(Icons.category),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchBar(
                controller: txtsearch,
                onChanged: (value) {
                  // if(value.isEmpty){
                  //   controller.getHomeData();
                  // }
                  if(value.isEmpty){
                    controller.getHomeData();
                  }
                  else{
                    controller.liveSearch(value);
                  }
                },
                trailing: const [
                  // IconButton(
                  //   onPressed: () {
                  //     controller.serchCategory = txtsearch.text;
                  //     controller.getSearch();
                  //   },
                  //   icon: const Icon(Icons.search),
                  // ),
                  Icon(Icons.search)
                ],
                hintText: "Search",
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(1),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: controller.incomeExpenseList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed('detail',
                              arguments: controller.incomeExpenseList[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, spreadRadius: 1)
                              ]),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.incomeExpenseList[index].title}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${controller.incomeExpenseList[index].date}",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.incomeExpenseList[index].amount}",
                                    style: TextStyle(
                                        color: controller
                                                    .incomeExpenseList[index]
                                                    .status ==
                                                "0"
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${controller.incomeExpenseList[index].time}",
                                    style: const TextStyle(color: Colors.grey),
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
              ),
            ],
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
  
  void showFiletrDialog(){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Filter"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionChip(label: Text("All"),onPressed: () {
                  Get.back();
                },),
                ActionChip(label: Text("Income"),onPressed: () {
                  controller.filterData(0);
                  Get.back();
                }),
                ActionChip(label: Text("Expense"),onPressed: () {
                  controller.filterData(1);
                  Get.back();
                }),
              ],
            )
          ],
        ),
      );
    },);
  }
}
