import 'package:expand_takers_app/screen/model/db_model.dart';
import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<DBModel> incomeExpenseList = <DBModel>[].obs;
  List<DBModel> filterList = [];
  List<DBModel> homeList = [];
  String? serchCategory;

  //date
  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;

  //total
  RxInt totalIncome = 0.obs;
  RxInt totalExpense = 0.obs;

  Future<void> getHomeData() async {
    homeList = await DbHelper.helper.readIncomeExpense();
    incomeExpenseList.value = homeList;
    getTotalIncomeExpense();
  }

  //search
  Future<void> filterData(int status) async {
    List<DBModel> s1 =
        await DbHelper.helper.filterIncomeExpenseata(status: status);
    incomeExpenseList.value = s1;
  }

  // total
  void getTotalIncomeExpense() {
    totalIncome.value=0;
    totalExpense.value=0;
    for (DBModel model in incomeExpenseList) {
      if (model.status == "0") {
        totalIncome = totalIncome + int.parse(model.amount!);
      } else {
        totalExpense = totalExpense + int.parse(model.amount!);
      }
    }
  }

  //live data
  void liveSearch(String search) {
    filterList.clear();
    for (DBModel model in homeList) {
      if (model.category!.toLowerCase().contains(search.toLowerCase())) {
        filterList.add(model);
      }
    }
    incomeExpenseList.value = List.from(filterList);
  }

//time
}
