import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/category_model.dart';
import 'package:wallefy/data/services/incomeService.dart';
import 'package:wallefy/presentation/routes/routes.dart';
import 'package:wallefy/presentation/widgets/custom_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final service = IncomeService();
  List<CategoryModel> categoryList = [];

  getAllUserDetails() async {
    categoryList = await service.readAllCategories();
    log("Category list length: ${categoryList.length}"); // Add this line to debug
    setState(() {});
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  String formatDate(String? dateTime) {
    if (dateTime == null) return "Invalid date";
    try {
      final parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy.MM.dd HH:mm').format(parsedDate);
    } catch (e) {
      log("Error parsing date: $e");
      return "Invalid date";
    }
  }

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
        centerTitle: true,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Slidable(
            useTextDirection: true,
            enabled: true,
            key: ValueKey(
              categoryList[index],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 2,
                  onPressed: (BuildContext context) {
                    Navigator.pushNamed(context, Routes.addEditCategoryPage,
                        arguments: {
                          'categoryModel': categoryList[index],
                        }).then((data) {
                      setState(() {});
                    });

                    Constants.showSuccessSnackBar(
                      'User Detail Updated Success',
                      context,
                    );
                  },
                  backgroundColor: const Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: "Edit",
                ),
                SlidableAction(
                  flex: 2,
                  onPressed: (BuildContext context) {
                    service.deleteCategory(categoryList[index].id);
                    setState(() {
                      categoryList.removeAt(index);
                    });
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Delete",
                ),
              ],
            ),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    categoryList[index].name ?? '',
                    style: AppTextStyles.body20w5.copyWith(
                      color: AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    formatDate(categoryList[index].dateTime),
                    style: AppTextStyles.body15w4.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: categoryList.length,
      ),
    );
  }
}
