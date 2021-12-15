import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:sqflite/sqflite.dart';

class UserOperations{
  late UserOperations userOperations;

  final dbHelper = DatabaseHelper.instance;

  Future<List<User>> getUser() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> items = await db.query('users', orderBy: 'id DESC',);

    return List.generate(items.length, (index) => User(nom: items[index]['nom'],id: items[index]['id']));
  }

  Future<void> add(User user) async {
    final db = await dbHelper.database;
    await db.insert('users', user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("Ajouté");
  }

}