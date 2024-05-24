
import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    super.key,
    required this.models,
  });

  final List<IncomeExpensesModel> models;

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    double rasxod = 0;
    double doxod = 0;

    for (int i = 0; i < models.length; i++) {
      if (models[i].isincome == 1) {
        doxod += models[i].price!;
      } else {
        rasxod += models[i].price!;
      }
    }
    sum = doxod - rasxod;
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
