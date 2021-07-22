class Meals {
  int _id;
  String _title;
  int _price;
  String _description;
  String _imageAsset;
  String _addingMealsTable;

  Meals(this._title, this._price, this._description, this._imageAsset,
      this._addingMealsTable);

  Meals.withId(this._id, this._title, this._price, this._description,
      this._imageAsset, this._addingMealsTable);

  int get id => _id;

  String get title => _title;

  int get price => _price;

  String get description => _description;

  String get imageAsset => _imageAsset;

  String get addingMealsTable => _addingMealsTable;

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

  set imageAsset(String newImageAsset) {
    this._imageAsset = newImageAsset;
  }

  set addingMealsTable(String newAddingMealsTable) {
    if (newAddingMealsTable.length <= 255) {
      this._description = newAddingMealsTable;
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
    map['imageAsset'] = _imageAsset;
    map['addingMealsTable'] = _addingMealsTable;

    return map;
  }

  Meals.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._price = map['price'];
    this._description = map['description'];
    this._imageAsset = map['imageAsset'];
    this._addingMealsTable = map['addingMealsTable'];
  }
}
