import 'package:flutter/material.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/services/incomeService.dart';
import 'package:wallefy/presentation/widgets/history_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<List<IncomeExpensesModel>> filterList = [];
  late List<IncomeExpensesModel> _dataList = <IncomeExpensesModel>[];
  final _userService = IncomeService();

  getAllUserDetails() async {
    List<List<IncomeExpensesModel>> filteredDataList = [];
    List allData = await _userService.readAllData();
    _dataList = <IncomeExpensesModel>[];
    allData.forEach((data) {
      setState(() {
        final dataModel = IncomeExpensesModel.fromJson(data);
        _dataList.add(dataModel);
      });
    });

    List<IncomeExpensesModel> newData = [..._dataList];

    for (int i = 0; i < newData.length; i++) {
      var a = newData[i].datatime;
      List<IncomeExpensesModel> set = [];
      for (int j = 0; j < newData.length; j++) {
        if (a == _dataList[j].datatime) {
          set.add(newData[j]);
          newData[j] = IncomeExpensesModel(datatime: '');
        }
      }
      if (set.isNotEmpty) {
        var reversedList = set.reversed.toList();
        filteredDataList.add(reversedList);
      }
    }
    filterList = filteredDataList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hikoya"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: filterList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return HistoryWidget(sortedDataList: filterList[index]);
        },
      ),
    );
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }
}
