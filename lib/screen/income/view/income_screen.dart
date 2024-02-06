import 'package:expand_takers_app/screen/model/db_model.dart';
import 'package:expand_takers_app/utils/db_helper.dart';
import 'package:flutter/material.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtCatagary = TextEditingController();

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
                TextFormField(
                  controller: txtCatagary,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Category"),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("05/02/2024"),
                    Text("01:30 PM"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green)),
                      onPressed: () {
                        DBModel model = DBModel(
                            title: txtTitle.text,
                            amount: txtAmount.text,
                            category: txtCatagary.text,
                            notes: txtNotes.text,
                            status: "0",
                            date: "06/02/2024",
                            time: "12:00");
                        DbHelper.helper.insertData(model);
                      },
                      child: const Text("Income",style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)),
                      onPressed: () {
                        DBModel model = DBModel(
                            title: txtTitle.text,
                            amount: txtAmount.text,
                            category: txtCatagary.text,
                            notes: txtNotes.text,
                            status: "1",
                            date: "06/02/2024",
                            time: "12:00");
                        DbHelper.helper.insertData(model);
                      },
                      child: const Text("Expense",style: TextStyle(color: Colors.white),),
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
}
