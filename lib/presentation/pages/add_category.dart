import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/category_model.dart';
import 'package:wallefy/data/services/incomeService.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController categoryController = TextEditingController();
  IncomeService service = IncomeService();
  bool _validateName = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategoriya qo'shish",
          style: AppTextStyles.body20w5.copyWith(
            color: AppColors.black,
          ),
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
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
                    ? "'Kategoriyalar maydoni bo'sh bo'lmasligi kerak"
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
                        var now = DateTime.now();
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String date = formatter.format(now);
                        await service.saveCategory(CategoryModel(
                          dateTime: date,
                          name: categoryController.text,
                        ));
                        Constants.showSuccessSnackBar(
                          'Данные успешно добавлены',
                          // ignore: use_build_context_synchronously
                          context,
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Qo'shish")),
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
