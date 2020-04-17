import 'package:flutterdatapersistence/models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  Future<Database> getDatabase() async {
    // create a database
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'mydatabase.db'),
      onCreate: (db, version) {
        return db.execute(
          """CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            email TEXT,
            password TEXT
          )""",
        );
      },
      version: 1,
    );

    return database;
  }

  // insert user
  Future<void> insertUser(User user) async {
    // get database
    final Database db = await getDatabase();

    // insert
    await db.insert('users', user.toMap());
  }

  // fetch User
  Future<User> fetchUserByEmail(String email) async {
    // get database
    final Database db = await getDatabase();

    List<Map<String, dynamic>> response =
        await db.query("users", where: "email = ?", whereArgs: [email]);

    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }
}
