import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/services/incomeService.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({
    super.key,
  });

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<List<IncomeExpensesModel>> filterList = [];
  late List<IncomeExpensesModel> _dataList = <IncomeExpensesModel>[];
  final _userService = IncomeService();
  double sum = 0;
  double rasxod = 0;
  double doxod = 0;

  getAllUserDetails() async {
    List<List<IncomeExpensesModel>> filteredDataList = [];
    List allData = await _userService.readAllData();
    _dataList = <IncomeExpensesModel>[];
    for (var data in allData) {
      setState(() {
        var dataModel = IncomeExpensesModel();
        dataModel.type = data['type'];
        dataModel.id = data['id'];
        dataModel.desc = data['desc'];
        dataModel.price = data['price'];
        dataModel.datatime = data['datatime'];
        dataModel.isincome = data['isincome'];
        _dataList.add(dataModel);
      });
    }

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

    for (int i = 0; i < filterList.length; i++) {
      for (int j = 0; j < filterList[i].length; j++) {
        if (filterList[i][j].isincome == 1) {
          doxod += filterList[i][j].price!;
        } else {
          rasxod += filterList[i][j].price!;
        }
      }
    }
    sum = doxod - rasxod;
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Positioned(
            top: 22,
            left: 29,
            child: Transform(
              transform: Matrix4.rotationZ(6.15),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20)),
                width: 330,
                height: 230,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 230,
              decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mening balansim',
                        style: AppTextStyles.body18w3
                            .copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: 10),
                      sum > 0
                          ? Text(
                              '+$sum UZS',
                              style: AppTextStyles.body18w4
                                  .copyWith(color: AppColors.white),
                            )
                          : Text(
                              '$sum UZS',
                              style: AppTextStyles.body18w4
                                  .copyWith(color: AppColors.white),
                            )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daromad',
                            style: AppTextStyles.body18w3
                                .copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '+$doxod UZS',
                            style: AppTextStyles.body18w3
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Harajat',
                            style: AppTextStyles.body18w3
                                .copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '-$rasxod UZS',
                            style: AppTextStyles.body18w3
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      Container()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
