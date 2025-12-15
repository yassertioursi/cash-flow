import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_factory.dart';
import 'db_seeds.dart';

class DbHelper {
  static Database? _database;
  static int get _dbVersion => 5;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    await configureDatabaseFactory();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cashflow.db');

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            fullName TEXT,
            email TEXT UNIQUE,
            password TEXT,
            phoneNumber TEXT,
            imageUrl TEXT,
            address TEXT,
            dateOfBirth TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE transaction_types(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL UNIQUE
          )
        ''');

        await db.execute('''
          CREATE TABLE categories(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL UNIQUE,
            icon_name TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE transactions(
            id TEXT PRIMARY KEY,
            user_id TEXT NOT NULL,
            name TEXT NOT NULL,
            amount_cents INTEGER NOT NULL,
            date TEXT NOT NULL,
            type_id INTEGER NOT NULL,
            category_id INTEGER NOT NULL,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
            FOREIGN KEY (type_id) REFERENCES transaction_types(id),
            FOREIGN KEY (category_id) REFERENCES categories(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE settings(
            id TEXT PRIMARY KEY,
            dataPreferences TEXT,
            budgetPreferences TEXT,
            appearancePreferences TEXT,
            notificationPreferences TEXT
          )
        ''');

        await db.execute('CREATE INDEX idx_transactions_user ON transactions(user_id)');
        await db.execute('CREATE INDEX idx_transactions_date ON transactions(date)');
        await db.execute('CREATE INDEX idx_transactions_category ON transactions(category_id)');
        await db.execute('CREATE INDEX idx_transactions_type ON transactions(type_id)');
        await db.execute('CREATE INDEX idx_users_email ON users(email)');

        await DbSeeds.seedAll(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _migrateDb(db, oldVersion, newVersion);
      },
    );
  }

  Future<void> _migrateDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id TEXT PRIMARY KEY,
          fullName TEXT,
          email TEXT UNIQUE,
          password TEXT,
          phoneNumber TEXT,
          imageUrl TEXT,
          address TEXT,
          dateOfBirth TEXT
        )
      ''');
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS settings(
          id TEXT PRIMARY KEY,
          dataPreferences TEXT,
          budgetPreferences TEXT,
          appearancePreferences TEXT,
          notificationPreferences TEXT
        )
      ''');
    }

    if (oldVersion < 4) {

      await db.execute('''
        CREATE TABLE IF NOT EXISTS transaction_types(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL UNIQUE
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS categories(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL UNIQUE,
          icon_name TEXT NOT NULL
        )
      ''');

      await DbSeeds.seedAll(db);

      final users = await db.query('users', limit: 1);
      final defaultUserId = users.isNotEmpty ? users.first['id'] as String : '';

      await db.execute('''
        CREATE TABLE transactions_new(
          id TEXT PRIMARY KEY,
          user_id TEXT NOT NULL,
          name TEXT NOT NULL,
          amount_cents INTEGER NOT NULL,
          date TEXT NOT NULL,
          type_id INTEGER NOT NULL,
          category_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
          FOREIGN KEY (type_id) REFERENCES transaction_types(id),
          FOREIGN KEY (category_id) REFERENCES categories(id)
        )
      ''');

      final oldTransactions = await db.query('transactions');
      for (final tx in oldTransactions) {
        final amount = tx['amount'] as int? ?? 0;
        final cents = tx['cents'] as int? ?? 0;
        final amountCents = amount * 100 + cents;

        final typeStr = tx['type']?.toString() ?? 'expense';
        final typeId = DbSeeds.getTypeId(typeStr);

        final categoryStr = tx['category']?.toString() ?? 'others';
        final categoryId = DbSeeds.getCategoryId(categoryStr);

        await db.insert('transactions_new', {
          'id': tx['id'],
          'user_id': defaultUserId,
          'name': tx['name'],
          'amount_cents': amountCents,
          'date': tx['date'],
          'type_id': typeId,
          'category_id': categoryId,
        });
      }

      await db.execute('DROP TABLE transactions');
      await db.execute('ALTER TABLE transactions_new RENAME TO transactions');

      await db.execute('CREATE INDEX IF NOT EXISTS idx_transactions_user ON transactions(user_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(date)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_transactions_category ON transactions(category_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(type_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)');
    }

    if (oldVersion < 5) {

      final users = await db.query('users', limit: 1);
      if (users.isNotEmpty) {
        final userId = users.first['id'] as String;

        await db.update(
          'transactions',
          {'user_id': userId},
          where: "user_id = '' OR user_id IS NULL",
        );
      }
    }
  }
}

