import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';

class CompteOperations{
  late CompteOperations compteOperations;

  final dbHelper = DatabaseHelper.instance;

  Future<int> saveCompte(CompteModel compteModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("comptes", compteModel.toMap());
    return res;
  }

  Future<List<CompteModel>?> getCompteModelData() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM comptes";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<CompteModel> list = result.map((item) {
      return CompteModel.fromMap(item);
    }).toList();
    getSomme();
    print(result);
    return list;
  }

  Future getSomme() async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTAL from comptes");
    print(res.toList());
    return res.toList();
  }

}