import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            CupertinoIcons.back,
            size: 28,
            color: AppColors.black,
          ),
        ),
        title: Text(
          "Kategoriya",
          style: AppTextStyles.body22w5.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      // body: ,
    );
  }
}
