import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/assets.dart';

class ValutePage extends StatefulWidget {
  const ValutePage({super.key});

  @override
  State<ValutePage> createState() => _ValutePageState();
}

class _ValutePageState extends State<ValutePage> {
  String selectedValute = 'uzb'; // выбранная валюта

  @override
  void initState() {
    super.initState();
    _loadSelectedValute();
  }

  // Tanlangan valyutani yuklash
  void _loadSelectedValute() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedValute = prefs.getString('selectedValute') ?? 'uzb';
      });
    } catch (e) {
      debugPrint('Error loading selected valute: $e');
    }
  }

  // Tanlangan valyutani saqlash
  void _saveSelectedValute(String valute) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedValute', valute);
    } catch (e) {
      debugPrint('Error saving selected valute: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            size: 25,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedValute = 'uzb';
                  _saveSelectedValute('uzb');
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.lightBgClr,
                    width: 1,
                  ),
                  color: selectedValute == 'uzb'
                      ? AppColors.yellow
                      : AppColors.lightBgClr,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.uzb,
                    ),
                    const SizedBox(width: 10),
                    const Text('UZB'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedValute = 'usa';
                  _saveSelectedValute('usa');
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.lightBgClr,
                    width: 1,
                  ),
                  color: selectedValute == 'usa'
                      ? AppColors.yellow
                      : AppColors.lightBgClr,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.usa,
                    ),
                    const SizedBox(width: 10),
                    const Text('USA'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Дополнительный функционал для выбранной валюты
            if (selectedValute == 'uzb') ...[
              const Text('Siz tanlagan valyuta: UZB'),
              // Добавьте сюда виджеты или данные для UZB
            ] else if (selectedValute == 'usa') ...[
              const Text('Siz tanlagan valyuta: USA'),
              // Добавьте сюда виджеты или данные для USA
            ],
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.yellow,
                ),
                child: Text(
                  "Tasdiqlash",
                  style: AppTextStyles.body20w4.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
