class Order {
  int _id;
  String _title;
  int _price;
  String _date;
  String _mealsTable;

  Order(this._title, this._date, this._price, this._mealsTable);

  Order.withId(
      this._id, this._title, this._date, this._price, this._mealsTable);

  int get id => _id;

  String get title => _title;

  int get price => _price;

  String get date => _date;

  String get mealsTable => _mealsTable;


  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set price(int newPrice) {
    this._price = newPrice;
  }

  set date(String newDate) {
    if (newDate.length <= 255) {
      this._date = newDate;
    }
  }

  set mealsTable(String newMealsTable) {
      this._mealsTable = newMealsTable;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['price'] = _price;
    map['date'] = _date;
    map['mealsTable'] = _mealsTable;

    return map;
  }

  Order.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._price = map['price'];
    this._date = map['date'];
    this._mealsTable = map['mealsTable'];
  }
}
