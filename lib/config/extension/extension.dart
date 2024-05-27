
import 'package:intl/intl.dart';

extension DateFormatter on String {
  String formatDate() {
    DateTime dateTime =
        DateTime.parse(this).toLocal(); // Парсинг с учетом местного времени
    DateFormat dateFormat = DateFormat(
        "dd-MM-yyyy"); // Форматирование с указанием временной зоны (здесь 'ru_RU' для России, можете использовать нужную вам)
    String output = dateFormat.format(dateTime);
    return output;
  }

  String formatTime() {
    DateTime dateTime = DateTime.parse(this).toLocal();
    DateFormat dateFormat = DateFormat("HH:mm");
    String output = dateFormat.format(dateTime
        .add(Duration(hours: int.tryParse(DateTime.now().timeZoneName) ?? 0)));
    return output;
  }

  String formatDateAndTime() {
    DateTime dateTime = DateTime.parse(this).toLocal();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String output = dateFormat.format(dateTime
        .add(Duration(hours: int.tryParse(DateTime.now().timeZoneName) ?? 0)));
    return output;
  }
}