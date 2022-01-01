import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/budgetModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';

class AutreOperations{
  late AutreOperations autreOperations;

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

  ///Budget
  Future<int> saveBudget(BudgetModel budgetModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("budgets", budgetModel.toMap());
    return res;
  }

  Future<List<BudgetModel>?> getBudgets() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM budgets";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<BudgetModel> list = result.map((item) {
      return BudgetModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<BudgetModel>?> getBudgetsByUser(User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM budgets WHERE user_id = ${user.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<BudgetModel> list = result.map((item) {
      return BudgetModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<BudgetModel> getBudgetById(int id,User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM budgets WHERE user_id = ${user.id} AND id = $id";

    var result = await dbClient.rawQuery(sql);

    return BudgetModel.fromMap(result.first);
  }

  Future<int> updateBudget(BudgetModel budgetModel) async {
    var dbClient = await dbHelper.database;
    var result = await dbClient.update("budgets", budgetModel.toMap(),
        where: "id = ?", whereArgs: [budgetModel.id]);
    return result;
  }

  Future<int> deleteBudget(int? id) async {
    int result;
    var dbClient = await dbHelper.database;
    result = await dbClient.rawDelete('DELETE FROM budgets WHERE id = $id');
    return result;
  }

  ///Catégories
  Future<int> saveCat(CategorieModel categorieModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("categories", categorieModel.toMap());
    return res;
  }

  Future<List<CategorieModel>?> getCat() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM categories";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<CategorieModel> list = result.map((item) {
      return CategorieModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<CategorieModel>?> getCatByUser(User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM categories WHERE user_id = ${user.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<CategorieModel> list = result.map((item) {
      return CategorieModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<CategorieModel> getCatById(int id,User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM categories WHERE user_id = ${user.id} AND id = $id";

    var result = await dbClient.rawQuery(sql);

    return CategorieModel.fromMap(result.first);
  }

  Future<List<CategorieModel>?> getCatByType(String type,User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM categories WHERE user_id = ${user.id} AND type LIKE '${type}'";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<CategorieModel> list = result.map((item) {
      return CategorieModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<int> updateCat(CategorieModel categorieModel) async {
    var dbClient = await dbHelper.database;
    var result = await dbClient.update("categories", categorieModel.toMap(),
        where: "id = ?", whereArgs: [categorieModel.id]);
    return result;
  }

  Future<int> deleteCat(int? id) async {
    int result;
    var dbClient = await dbHelper.database;
    result = await dbClient.rawDelete('DELETE FROM categories WHERE id = $id');
    return result;
  }

  Future getSommeBudget(User user, int cat_id, DateTime debut, DateTime fin) async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTAL from transactions WHERE user_id = ${user.id} AND cat_id = $cat_id AND datetime BETWEEN '${debut}' AND '${fin}'");
    return res.toList();
  }

}