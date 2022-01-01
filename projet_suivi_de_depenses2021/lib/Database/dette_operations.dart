import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';

class DetteOperations{
  late DetteOperations autreOperations;

  final dbHelper = DatabaseHelper.instance;

  ///Dette
  Future<int> saveDette(DetteModel detteModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("dettes", detteModel.toMap());
    return res;
  }

  Future<List<DetteModel>?> getDettes() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM dettes";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<DetteModel> list = result.map((item) {
      return DetteModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<DetteModel>?> getDettesByUser(User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM dettes WHERE user_id = ${user.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<DetteModel> list = result.map((item) {
      return DetteModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<DetteModel> getDetteById(int id) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM dettes WHERE id = $id";

    var result = await dbClient.rawQuery(sql);

    return DetteModel.fromMap(result.first);
  }

  Future<int> updateDette(DetteModel detteModel) async {
    var dbClient = await dbHelper.database;
    var result = await dbClient.update("dettes", detteModel.toMap(),
        where: "id = ?", whereArgs: [detteModel.id]);
    return result;
  }

  Future<int> deleteDette(int? id) async {
    int result;
    var dbClient = await dbHelper.database;
    result = await dbClient.rawDelete('DELETE FROM dettes WHERE id = $id');
    return result;
  }

}