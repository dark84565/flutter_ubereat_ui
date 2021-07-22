import 'dart:io';
import 'package:interview_demo/Models/AddingMeals.dart';
import 'package:interview_demo/Models/Meals.dart';
import 'package:interview_demo/Models/Order.dart';
import 'package:interview_demo/Models/Stores.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  Database _database;
  String table;
  int type;
  String id = 'id';
  String title = 'title';
  String price = 'price';
  String description = 'description';
  String score = 'score';
  String shippingFee = 'shippingFee';
  String imageAsset = 'imageAsset';
  String date = 'date';
  String mealsTable = 'mealsTable';
  String addingMealsTable = 'addingMealsTable';

  DatabaseHelper(String tableName, dataType) {
    //type 0 : storesDatabase, type 1 : mealsDatabase, type 2 : addingMealsDatabase, type 3 : orderDatabase,
    dataType == 0
        ? table = 'storesTable'
        : dataType == 1 || dataType == 2
            ? table = tableName
            : table = 'orderTable';
    type = dataType;
  }

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + table + '.db';

    // Open/create the database at a given path
    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    type == 0
        ? await db.execute(
            'CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $description TEXT, '
            '$score REAL, $shippingFee INTEGER, $imageAsset TEXT, $mealsTable TEXT)')
        : type == 1
            ? await db.execute(
                'CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $price INTEGER, '
                '$description TEXT, $imageAsset TEXT, $addingMealsTable TEXT)')
            : type == 2
                ? await db.execute(
                    'CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $price INTEGER, '
                    '$description TEXT)')
                : await db.execute(
                    'CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $price INTEGER, '
                    '$date TEXT, $mealsTable TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getMapList() async {
    Database db = await this.database;

    var result = await db.query(table, orderBy: '$id ASC');
    return result;
  }

  Future<List<Stores>> getStoresList() async {
    var storesMapList = await getMapList(); // Get 'Map List' from database
    int count =
        storesMapList.length; // Count the number of map entries in db table
    List<Stores> storesList = List<Stores>();
    for (int i = 0; i < count; i++) {
      storesList.add(Stores.fromMapObject(storesMapList[i]));
    }
    return storesList;
  }

  Future<List<Meals>> getMealsList() async {
    var mealsMapList = await getMapList(); // Get 'Map List' from database
    int count =
        mealsMapList.length; // Count the number of map entries in db table
    List<Meals> mealsList = List<Meals>();
    for (int i = 0; i < count; i++) {
      mealsList.add(Meals.fromMapObject(mealsMapList[i]));
    }
    return mealsList;
  }

  Future<List<AddingMeals>> getAddingMealsList() async {
    var addingMealsMapList = await getMapList(); // Get 'Map List' from database
    int count = addingMealsMapList
        .length; // Count the number of map entries in db table
    List<AddingMeals> addingMealsList = List<AddingMeals>();
    for (int i = 0; i < count; i++) {
      addingMealsList.add(AddingMeals.fromMapObject(addingMealsMapList[i]));
    }
    return addingMealsList;
  }

  Future<List<Order>> getOrderList() async {
    var orderMapList = await getMapList(); // Get 'Map List' from database
    int count =
        orderMapList.length; // Count the number of map entries in db table
    List<Order> orderList = List<Order>();
    for (int i = 0; i < count; i++) {
      orderList.add(Order.fromMapObject(orderMapList[i]));
    }
    return orderList;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertData(
      [Stores stores,
      Meals meals,
      AddingMeals addingMeals,
      Order order]) async {
    Database db = await this.database;

    var result;
    stores != null
        ? result = await db.insert(table, stores.toMap())
        : meals != null
            ? result = await db.insert(table, meals.toMap())
            : addingMeals != null
                ? result = await db.insert(table, addingMeals.toMap())
                : order != null
                    ? result = await db.insert(table, order.toMap())
                    : result = null;

    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateData(
      [Stores stores,
      Meals meals,
      AddingMeals addingMeals,
      Order order]) async {
    var db = await this.database;

    var result;
    stores != null
        ? result = await db.update(table, stores.toMap(),
            where: '$id = ?', whereArgs: [stores.id])
        : meals != null
            ? result = await db.update(table, meals.toMap(),
                where: '$id = ?', whereArgs: [meals.id])
            : addingMeals != null
                ? result = await db.update(table, addingMeals.toMap(),
                    where: '$id = ?', whereArgs: [addingMeals.id])
                : result = await db.update(table, order.toMap(),
                    where: '$id = ?', whereArgs: [order.id]);

    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $table WHERE $id = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
}
