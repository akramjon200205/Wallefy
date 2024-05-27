import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/presentation/routes/routes.dart';
import 'package:wallefy/presentation/widgets/sold_products.dart';

import '../../data/services/incomeService.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({
    super.key,
    required this.sortedDataList,
  });
  final List<IncomeExpensesModel> sortedDataList;

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final IncomeService _incomeService = IncomeService();

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    double rasxod = 0;
    double doxod = 0;
    for (int i = 0; i < widget.sortedDataList.length; i++) {
      if (widget.sortedDataList[i].isincome == 1) {
        doxod += widget.sortedDataList[i].price!;
      } else {
        rasxod += widget.sortedDataList[i].price!;
      }
    }
    sum = doxod - rasxod;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.sortedDataList.first.datatime ?? '',
                style: AppTextStyles.body20wB,
              ),
              sum > 0
                  ? Text(
                      '+$sum UZS',
                      style: AppTextStyles.body18w4
                          .copyWith(color: AppColors.lastAction),
                    )
                  : Text(
                      '$sum UZS',
                      style: AppTextStyles.body18w4
                          .copyWith(color: AppColors.lastAction),
                    )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: List.generate(
              widget.sortedDataList.length,
              (index) => Slidable(
                key: ValueKey(widget.sortedDataList[index]),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 2,
                      onPressed: (BuildContext context) {
                        Navigator.pushNamed(context, Routes.editData,
                            arguments: {
                              'user': widget.sortedDataList[index]
                            }).then((data) {
                          Constants.showSuccessSnackBar(
                            'User Detail Updated Success',
                            context,
                          );
                          setState(() {});
                        });
                      },
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: "O'zgartirish",
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        _incomeService
                            .deleteData(widget.sortedDataList[index].id);
                        widget.sortedDataList.removeAt(index);
                        Navigator.pop(context);                        
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: "O'chirish",
                    ),
                  ],
                ),
                child: SoldProducts(
                  desc: widget.sortedDataList[index].desc ?? '',
                  isIncoming: widget.sortedDataList[index].isincome == 1,
                  price: (widget.sortedDataList[index].price ?? 0).toString(),
                  // time: dataList[index].datatime!,
                  type: widget.sortedDataList[index].type ?? '',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void edit(BuildContext context) {
//  _incomeService.deleteData(userId);
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
}
