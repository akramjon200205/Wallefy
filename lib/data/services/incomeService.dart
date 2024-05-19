
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/repositories/repository.dart';

class IncomeService {
  late Repository _repository;
  IncomeService() {
    _repository = Repository();
  }
  //Save User
  saveData(IncomeExpensesModel user) async {
    return await _repository.insertData('mydb', user.toMap());
  }

  //Read All Users
  readAllData() async {
    return await _repository.readData('mydb');
  }

  //Edit User
  updateData(IncomeExpensesModel user) async {
    return await _repository.updateData('mydb', user.toMap());
  }

  deleteData(userId) async {
    return await _repository.deleteDataById('mydb', userId);
  }
}
