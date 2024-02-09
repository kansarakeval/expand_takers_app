import 'package:expand_takers_app/screen/model/db_model.dart';
import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<DBModel> incomeExpenseList = <DBModel>[].obs;
  List<DBModel> filterList=[];
  String? serchCategory;

  Future<void> getHomeData() async {
    List<DBModel> homeList = await DbHelper.helper.readIncomeExpense();
    incomeExpenseList.value = homeList;
  }

  //live data
  void liveSearch(String search) {
    filterList.clear();
    for (DBModel model in incomeExpenseList) {
      if(model.category!.toLowerCase().contains(search.toLowerCase())){
        filterList.add(model);
      }
    }
    incomeExpenseList.value = List.from(filterList);
  }

  //search
  Future<void> getSearch() async {
    List<DBModel> s1 =
    await DbHelper.helper.serchdincomeExpenseata(category: serchCategory!);
    incomeExpenseList.value = s1;
  }
}
