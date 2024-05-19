import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';

class DraverButton extends StatelessWidget {
  const DraverButton({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            text,
            style: AppTextStyles.body18w5.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
