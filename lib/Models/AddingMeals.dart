class AddingMeals {
  int _id;
  String _title;
  int _price;
  String _description;

  AddingMeals(this._title, this._description, this._price);

  AddingMeals.withId(this._id, this._title, this._description, this._price);

  int get id => _id;

  String get title => _title;

  int get price => _price;

  String get description => _description;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set price(int newPrice) {
    this._price = newPrice;
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['price'] = _price;
    map['description'] = _description;

    return map;
  }

  AddingMeals.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._price = map['price'];
    this._description = map['description'];
  }
}
