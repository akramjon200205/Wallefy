import 'package:wallefy/data/models/category_model.dart';
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

  // Save Category
  saveCategory(CategoryModel user) async {
    return await _repository.insertData('myctg', user.toMap());
  }

  //Read All Users
  readAllData() async {
    return await _repository.readData('mydb');
  }

  //Read All CAtegories
  readAllCategories() async {
    return await _repository.readCategory('myctg');
  }   

  //Edit User
  updateData(IncomeExpensesModel user) async {
    return await _repository.updateData('mydb', user.toMap());
  }

  //Edit Categories
  updateCategory(CategoryModel user) async {
    return await _repository.updateData('myctg', user.toMap());
  }

  // Delete User Data
  deleteData(userId) async {
    return await _repository.deleteDataById('mydb', userId);
  }

  // Delete Category
  deleteCategory(categoryId) async {
    return await _repository.deleteDataById('myctg', categoryId);
  }
}
