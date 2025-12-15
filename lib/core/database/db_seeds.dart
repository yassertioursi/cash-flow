import 'package:sqflite/sqflite.dart';

class DbSeeds {

  static Future<void> seedTransactionTypes(Database db) async {
    await db.insert('transaction_types', {'id': 1, 'name': 'income'},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.insert('transaction_types', {'id': 2, 'name': 'expense'},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<void> seedCategories(Database db) async {
    final categories = [
      {'id': 1, 'name': 'food', 'icon_name': 'fastfood_outlined'},
      {'id': 2, 'name': 'transport', 'icon_name': 'directions_car_outlined'},
      {'id': 3, 'name': 'bills', 'icon_name': 'home_work_outlined'},
      {'id': 4, 'name': 'health', 'icon_name': 'health_and_safety_outlined'},
      {'id': 5, 'name': 'shopping', 'icon_name': 'shopping_cart_outlined'},
      {'id': 6, 'name': 'entertainment', 'icon_name': 'movie_outlined'},
      {'id': 7, 'name': 'salary', 'icon_name': 'money_outlined'},
      {'id': 8, 'name': 'others', 'icon_name': 'miscellaneous_services_outlined'},
    ];

    for (final category in categories) {
      await db.insert('categories', category,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  static Future<void> seedAll(Database db) async {
    await seedTransactionTypes(db);
    await seedCategories(db);
  }

  static int getCategoryId(String categoryName) {
    const categoryMap = {
      'food': 1,
      'transport': 2,
      'bills': 3,
      'health': 4,
      'shopping': 5,
      'entertainment': 6,
      'salary': 7,
      'others': 8,
    };
    return categoryMap[categoryName.toLowerCase()] ?? 8;
  }

  static int getTypeId(String typeName) {
    return typeName.toLowerCase() == 'income' ? 1 : 2;
  }

  static String getCategoryName(int id) {
    const idMap = {
      1: 'food',
      2: 'transport',
      3: 'bills',
      4: 'health',
      5: 'shopping',
      6: 'entertainment',
      7: 'salary',
      8: 'others',
    };
    return idMap[id] ?? 'others';
  }

  static String getTypeName(int id) {
    return id == 1 ? 'income' : 'expense';
  }
}
