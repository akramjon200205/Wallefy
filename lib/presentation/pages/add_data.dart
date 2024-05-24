import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/services/incomeService.dart';

import '../../config/constants/app_text_styles.dart';

class AddData extends StatefulWidget {
  const AddData({super.key, required this.isTrue});
  final bool isTrue;
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateType = false;
  final _userService = IncomeService();
  String typeExcenses = 'Kategoriyani tanlang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isTrue
            ? Text(
                'Yangi kirim',
                style: AppTextStyles.body22w5.copyWith(color: AppColors.white),
              )
            : Text(
                'Yangi chiqim',
                style: AppTextStyles.body22w5.copyWith(color: AppColors.white),
              ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Eslatmani kiriting',
                    labelText: 'Eslatma',
                    errorText: _validateName
                        ? "Eslatma maydoni bo'sh bo'lmasligi kerak"
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Summani kiriting',
                    labelText: 'Miqdor',
                    errorText: _validateContact
                        ? "'Miqdor' maydoni bo'sh bo'lmasligi kerak"
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  bottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Text(typeExcenses),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _validateType
                  ? Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        'Kategoriyalardan birini tanlang',
                        style: AppTextStyles.body14w5
                            .copyWith(color: AppColors.red),
                      ),
                    )
                  : const Text(''),
              const SizedBox(
                height: 20.0,
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
                          _descController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _priceController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          typeExcenses == 'Kategoriyani tanlang'
                              ? _validateType = true
                              : _validateType = false;
                        });
                        if (_validateName == false &&
                            _validateContact == false &&
                            typeExcenses != 'Kategoriyani tanlang') {
                          // print("Good Data Can Save");
                          var now = DateTime.now();
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          final String date = formatter.format(now);
                          await _userService.saveData(
                            IncomeExpensesModel(
                                type: typeExcenses,
                                desc: _descController.text,
                                price: double.parse(_priceController.text),
                                datatime: monthReturned(date),
                                isincome: widget.isTrue == true ? 1 : 0),
                          );
                          // ignore: use_build_context_synchronously
                          Constants.showSuccessSnackBar(
                              'Данные успешно добавлены', context);

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
                        _descController.text = '';
                        _priceController.text = '';
                      },
                      child: const Text('Tozalash')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: typeExcensesList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (_, index) => Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    typeExcenses = typeExcensesList[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(typeExcensesList[index]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
