import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/category_model.dart';
import 'package:wallefy/data/services/incomeService.dart';

// ignore: must_be_immutable
class AddEditCategoryPage extends StatefulWidget {
  CategoryModel categoryModel;
  AddEditCategoryPage({
    super.key,
    required this.categoryModel,
  });

  @override
  State<AddEditCategoryPage> createState() => _AddEditCategoryPageState();
}

class _AddEditCategoryPageState extends State<AddEditCategoryPage> {
  TextEditingController categoryController = TextEditingController();
  IncomeService service = IncomeService();
  bool _validateName = false;

  @override
  void initState() {
    setState(() {
      categoryController.text = widget.categoryModel.name ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Kategoriyani tahrirlash",
          style: AppTextStyles.body20w5.copyWith(
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: categoryController,
              style: AppTextStyles.body16w4.copyWith(color: AppColors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.black,
                    width: 1,
                  ),
                ),
                errorText: _validateName
                    ? "'Eslatma' maydoni bo'sh bo'lmasligi kerak"
                    : null,
                hintText: "Yangi Kategoriya kiriting",
                hintStyle: AppTextStyles.body16w4.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: () async {
                      setState(() {
                        categoryController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                      });
                      if (_validateName == false) {
                        // print("Good Data Can Save");
                        var user = CategoryModel(
                          id: widget.categoryModel.id,
                          dateTime: DateTime.now().toString(),
                          name: categoryController.text,
                        );
                        await service.updateCategory(user);
                        Constants.showSuccessSnackBar(
                          'Данные успешно добавлены',
                          // ignore: use_build_context_synchronously
                          context,
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Yangilash')),
                const SizedBox(
                  width: 10.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    categoryController.text = '';
                  },
                  child: const Text('Tozalash'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
