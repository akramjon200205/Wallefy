import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/category_model.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/services/incomeService.dart';

class EditData extends StatefulWidget {
  final IncomeExpensesModel user;
  const EditData({super.key, required this.user});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateType = false;
  final _userService = IncomeService();
  String typeExcenses = '';

  List<CategoryModel> categoryList = [];

  getAllCategoryDetails() async {
    categoryList = await _userService.readAllCategories();
    // for (var element in categoryList) {
    //   log("${element.name}");
    // }
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      _descController.text = widget.user.desc ?? '';
      _priceController.text = ((widget.user.price).toString());
      typeExcenses = widget.user.type ?? '';
    });
    getAllCategoryDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma'lumotlarni tahrirlash"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Yangi Eslatma kitirish',
                    labelText: 'Eslatma',
                    errorText: _validateName
                        ? "'Eslatma' maydoni bo'sh bo'lmasligi kerak"
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Yangi Summa kiritish',
                    labelText: 'Summa',
                    errorText: _validateContact
                        ? "Summa maydoni bo'sh bo'lmasligi kerak"
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
                        'Siz kategoriyalardan birini tanlashingiz kerak',
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
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _descController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _priceController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          typeExcenses == 'Kategoriyani kiriting'
                              ? _validateType = true
                              : _validateType = false;
                        });
                        if (_validateName == false &&
                            _validateContact == false) {
                          // print("Good Data Can Save");
                          var user = IncomeExpensesModel(
                            id: widget.user.id,
                            desc: _descController.text,
                            type: typeExcenses,
                            isincome: widget.user.isincome,
                            datatime: widget.user.datatime,
                            price: double.parse(_priceController.text),
                          );
                          await _userService.updateData(user);
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
                      _descController.text = '';
                      _priceController.text = '';
                    },
                    child: const Text('Tozalash'),
                  ),
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
            itemCount: categoryList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (_, index) => Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    typeExcenses = categoryList[index].name ?? '';
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  categoryList[index].name ?? '',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
