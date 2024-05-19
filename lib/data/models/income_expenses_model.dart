class IncomeExpensesModel {
  int? id;
  String? type;
  String? desc;
  String? datatime;
  int? isincome;
  double? price;

  IncomeExpensesModel(
      {this.id,
      this.type,
      this.desc,
      this.datatime,
      this.isincome,
      this.price});

  IncomeExpensesModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    desc = json['desc'];
    datatime = json['datatime'];
    isincome = json['isincome'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['desc'] = desc;
    data['datatime'] = datatime;
    data['isincome'] = isincome;
    data['price'] = price;
    return data;
  }
}
