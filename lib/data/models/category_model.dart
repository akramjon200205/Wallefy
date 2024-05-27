class CategoryModel {
  int? id;
  String? name;
  String? dateTime;
  CategoryModel({
    this.dateTime,
    this.id,
    this.name,
  });
  CategoryModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateTime =  json['datatime'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['datatime'] = dateTime;

    return data;
  }
}
