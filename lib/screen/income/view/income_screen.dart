import 'package:expand_takers_app/screen/category/controller/category_controller.dart';
import 'package:expand_takers_app/screen/home/controller/home_controller.dart';
import 'package:expand_takers_app/screen/model/db_model.dart';
import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  DBModel? updbModel = Get.arguments;
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtNotes = TextEditingController();

  CategoryController controller = Get.put(CategoryController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getController();
    homeController.getHomeData();

    if (updbModel != null) {
      txtTitle = TextEditingController(text: updbModel!.title);
      txtAmount = TextEditingController(text: updbModel!.amount);
      txtNotes = TextEditingController(text: updbModel!.notes);
      controller.selectCategory.value = updbModel!.category;

      List date= updbModel!.date!.split('/');
      homeController.date.value = DateTime(int.parse(date[2]),int.parse(date[1]),int.parse(date[0]));

      List time= updbModel!.time!.split(':');
      homeController.time.value = TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Income"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: txtTitle,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "pleas enter the title";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: txtAmount,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "pleas enter the title";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => DropdownButton(
                    value: controller.selectCategory.value,
                    hint: Text("selected"),
                    isExpanded: true,
                    items: controller.categoryList
                        .map((e) => DropdownMenuItem(
                              child: Text(e['name']),
                              value: "${e['name']}",
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectCategory.value = value as String;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: txtNotes,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Notes"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          DateTime? d1= await showDatePicker(
                            context: context,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2050),
                          );
                          homeController.date.value =d1!;
                        },
                        icon: Icon(Icons.calendar_month)),
                    Obx(() =>Text("${homeController.date.value.day}/${homeController.date.value.month}/${homeController.date.value.year}")),
                    Spacer(),
                    IconButton(
                        onPressed: () async {
                         TimeOfDay? t1= await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                         homeController.time.value = t1!;
                        },
                        icon: Icon(Icons.watch_later_outlined)),
                    Obx(() => Text("${homeController.time.value.hour}:${homeController.time.value.minute}"))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green)),
                      onPressed: () {
                        DBModel model = DBModel(
                            id: updbModel?.id,
                            title: txtTitle.text,
                            amount: txtAmount.text,
                            category: controller.selectCategory.value,
                            notes: txtNotes.text,
                            status: "0",
                            date: "${homeController.date.value.day}/${homeController.date.value.month}/${homeController.date.value.year}",
                            time: "${homeController.time.value.hour}:${homeController.time.value.minute}");

                        if (updbModel == null) {
                          DbHelper.helper.insertData(model);
                        } else {
                          DbHelper.helper.updateincomeExpenseData(model);
                        }

                        homeController.getHomeData();
                        Get.offAllNamed('/');
                      },
                      child: const Text(
                        "Income",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red)),
                      onPressed: () {
                        DBModel model = DBModel(
                            id: updbModel?.id,
                            title: txtTitle.text,
                            amount: txtAmount.text,
                            category: controller.selectCategory.value,
                            notes: txtNotes.text,
                            status: "1",
                            date: "${homeController.date.value.day}/${homeController.date.value.month}/${homeController.date.value.year}",
                            time: "${homeController.time.value.hour}:${homeController.time.value.minute}");

                        if (updbModel == null) {
                          DbHelper.helper.insertData(model);
                        } else {
                          DbHelper.helper.updateincomeExpenseData(model);
                        }
                        homeController.getHomeData();
                        Get.offAllNamed('/');
                      },
                      child: const Text(
                        "Expense",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.selectCategory.value = null;
  }
}
