import 'package:expand_takers_app/screen/model/db_model.dart';
import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<DBModel> incomeExpenseList = <DBModel>[].obs;

  Future<void> getHomeData() async {
    List<DBModel> homeList= await DbHelper.helper.readInconmeExpense();
    incomeExpenseList.value = homeList;
  }
}
