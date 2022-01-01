import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';

class CompteOperations{
  late CompteOperations compteOperations;

  final dbHelper = DatabaseHelper.instance;

  Future<int> saveCompte(CompteModel compteModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("comptes", compteModel.toMap());
    return res;
  }

  Future<List<CompteModel>?> getCompte() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM comptes";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<CompteModel> list = result.map((item) {
      return CompteModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<CompteModel>?> getCompteByUser(User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM comptes WHERE user_id = ${user.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<CompteModel> list = result.map((item) {
      return CompteModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<CompteModel> getCompteById(int id) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM comptes WHERE id = $id";

    var result = await dbClient.rawQuery(sql);

    return CompteModel.fromMap(result.first);
  }

  Future getSomme(User user) async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTAL from comptes WHERE user_id = ${user.id}");
    return res.toList();
  }

  Future<int> updateCompte(CompteModel compteModel) async {
    var dbClient = await dbHelper.database;
    var result = await dbClient.update("comptes", compteModel.toMap(),
        where: "id = ?", whereArgs: [compteModel.id]);
    return result;
  }

  Future<int> deleteCompte(int? id) async {
    int result;
    var dbClient = await dbHelper.database;
    result = await dbClient.rawDelete('DELETE FROM comptes WHERE id = $id');
    return result;
  }

}