import 'package:expand_takers_app/screen/category/controller/category_controller.dart';
import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController txtcategory = TextEditingController();

  var key = GlobalKey<FormState>();

  CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    controller.getController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("category"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: txtcategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a category name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    DbHelper.helper.insertCategoryData(name: txtcategory.text);
                    controller.getController();
                  }
                },
                child: const Text("Add"),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text("${controller.categoryList[index]['name']}"),
                        trailing: IconButton(
                          onPressed: () {
                            DbHelper.helper.deleteCategoryData(
                                id: "${controller.categoryList[index]['id']}");
                            controller.getController();
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                    itemCount: controller.categoryList.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
