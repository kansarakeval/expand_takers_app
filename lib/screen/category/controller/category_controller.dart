import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map> categoryList = <Map>[].obs;
  RxnString selectCategory = RxnString();

  Future<void> getController() async {
    List<Map> data = await DbHelper.helper.readCategoryData();
    categoryList.value = data;
  }

}
