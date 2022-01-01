import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:sqflite/sqflite.dart';

class UserOperations{
  late UserOperations userOperations;

  final dbHelper = DatabaseHelper.instance;

  Future<User> getUser(int id) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM users WHERE id = $id";

    var result = await dbClient.rawQuery(sql);

    return User.fromMap(result.first);
  }

  Future<int?> getCount() async {
    var dbClient = await dbHelper.database;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM users")
    );
    return result;
  }

  Future<void> add(User user) async {
    final db = await dbHelper.database;
    await db.insert('users', user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("Ajouté");
  }

}