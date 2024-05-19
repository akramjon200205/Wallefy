
import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';

class SoldProducts extends StatelessWidget {
  SoldProducts({
    super.key,
    required this.type,
    required this.desc,
    // required this.time,
    required this.price,
    required this.isIncoming,
  });
  final String type;
  final String desc;
  // final String time;
  final String price;
  final bool isIncoming;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isIncoming ? AppColors.actionsClmnnClr : AppColors.red,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color:
                        isIncoming ? AppColors.actionsClmnnClr : AppColors.red,
                    blurRadius: 5)
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: AppTextStyles.body16w5,
              ),
              const SizedBox(height: 5),
              Text(
                desc,
                style: AppTextStyles.body14w4
                    .copyWith(color: AppColors.lastAction),
              ),
              // SizedBox(height: 5.h),
              // Text(time, style: AppTextStyles.body11w4),
            ],
          ),
          const Spacer(),
          Text(
            price,
            style: AppTextStyles.body16w5.copyWith(
              color: isIncoming ? AppColors.actionsClmnnClr : AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
