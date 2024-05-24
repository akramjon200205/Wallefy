import 'package:flutter/material.dart';
import 'package:wallefy/presentation/pages/home.dart';
import 'package:wallefy/presentation/pages/settings.dart';

List<String> menuNames = ['Uy', 'Tarix'];
List<Icon> menuIcons = [
  const Icon(Icons.home_outlined),
  const Icon(Icons.history_outlined)
];
List floatListNames = ["Yangi daromad", "Yangi harajat"];
List floatListIcons = [
  Icons.add_circle_outline_sharp,
  Icons.remove_circle_outline_outlined
];

TextStyle kTextstyle(
    {Color? color,
    double? size = 32,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    double? letterSpasing}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpasing,
      height: height);
}

final List<String> buttons = [
  '÷',
  '7',
  '8',
  '9',
  'x',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  '=',
];

//проверка на оператор
bool isOperator(String x) {
  if (x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

String monthReturned(String date) {
  var day = int.parse(date.substring(8, 10));
  var month = int.parse(date.substring(5, 7));
  String monthName = '';

  switch (month) {
    case 1:
      monthName = 'Yanvar';
      break;
    case 2:
      monthName = 'Fevral';
      break;
    case 3:
      monthName = 'Mart';
      break;
    case 4:
      monthName = 'Aprel';
      break;
    case 5:
      monthName = 'May';
      break;
    case 6:
      monthName = 'Iyun';
      break;
    case 7:
      monthName = 'Iyul';
      break;
    case 8:
      monthName = 'Avgust';
      break;
    case 9:
      monthName = 'Sentyabr';
      break;
    case 10:
      monthName = 'Oktyabr';
      break;
    case 11:
      monthName = 'Noyabr';
      break;
    case 12:
      monthName = 'Dekabr';
      break;
    default:
      monthName = 'Bunday oy yo\'q';
  }
  return '$day $monthName';
}

List<String> typeExcensesList = [
  'Transport',
  'Mahsulotlar',
  'Bolalar',
  'Xaridlar',
  'Telefon',
  'Uy',
  'Dorixona',
  'O\'yin-kulgi',
  'Salomatlik',
  'Restorantlar',
  'Soliqlar',
  'O\'yinlar',
  'Internet',
  'Sport',
];

List<Widget> pages = [
  const HomePage(),
  const SettingsPage(),
  Container(),
];
List<String> pageNames = ['Asosiy menu', 'Sozlamalar', 'Dastur haqida'];
List<IconData> pageIcons = [Icons.home, Icons.settings, Icons.info];

List<String> currencies = [
  'USD',
  'RUB',
  'UZS',
];
List<String> languages = [
  'English',
  'Русский',
  'O\'zbekcha',
];

class Constants {
  static showSuccessSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Builder(builder: (context) {
          return Text(message);
        }),
      ),
    );
  }
}
