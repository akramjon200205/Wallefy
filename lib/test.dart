

void main(List<String> args) {
  List<List> filteredList = [];
  List dataCopy = [];
  dataCopy.addAll(data);
  for (int i = 0; i < data.length; i++) {
    String item = data[i];
    List set = [];

    for (int j = 0; j < dataCopy.length; j++) {
      if (item == dataCopy[j]) {
        set.add(dataCopy[j]);
        dataCopy[j] = 0;
      }
    }
    if (set.isNotEmpty) {
      filteredList.add(set);
    }
  }
  // print(filteredList.length);
  getData(filteredList);
}

getData(List<List> list) {
  for (int i = 0; i < data.length; i++) {
    print(list[i]);
    print('>---------<');
  }
}

List<String> data = [
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '00',
  '06',
  '07',
  '08',
  '09',
  '08',
  '08',
];
