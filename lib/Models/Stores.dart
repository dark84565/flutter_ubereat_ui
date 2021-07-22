class Stores {
  int _id;
  String _title;
  String _description;
  double _score;
  int _shippingFee;
  String _imageAsset;
  String _mealsTable;

  Stores(this._title, this._description, this._score,
      this._shippingFee, this._imageAsset, this._mealsTable);

  Stores.withId(this._id, this._title, this._description, this._score,
      this._shippingFee, this._imageAsset, this._mealsTable);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  double get score => _score;

  int get shippingFee => _shippingFee;

  String get imageAsset => _imageAsset;

  String get mealsTable => _mealsTable;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set score(double newScore) {
    this._score = newScore;
  }

  set shippingFee(int newShippingFee) {
    this._shippingFee = newShippingFee;
  }

  set imageAsset(String newImageAsset) {
    this._imageAsset = newImageAsset;
  }

  set mealsTable(String newMealsTable) {
    if (newMealsTable.length <= 255) {
      this._mealsTable = newMealsTable;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['score'] = _score;
    map['shippingFee'] = _shippingFee;
    map['imageAsset'] = _imageAsset;
    map['mealsTable'] = _mealsTable;

    return map;
  }

  Stores.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._score = map['score'];
    this._shippingFee = map['shippingFee'];
    this._imageAsset = map['imageAsset'];
    this._mealsTable = map['mealsTable'];
  }
}
