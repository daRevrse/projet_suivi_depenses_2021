import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/remboursementModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:sqflite/sqflite.dart';

class TransactionOperations{
  late TransactionOperations transactionOperations;

  final dbHelper = DatabaseHelper.instance;


  ///Transactions
  Future<int> saveTransaction(TransactionModel transactionModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("transactions", transactionModel.toMap());
    return res;
  }

  Future<List<TransactionModel>?> getTransactions() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();

    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByUser(User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByCompte(User user,CompteModel compte) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND compte_id = ${compte.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByType(User user,String type) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND type = '${type}'";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByCategorie(User user,CategorieModel cat) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND cat_id = ${cat.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByCategorieByType(User user,String type,CategorieModel cat) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND cat_id = ${cat.id} AND type LIKE '$type'";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByCatForBudget(User user,CategorieModel cat,DateTime debut, DateTime fin) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND cat_id = ${cat.id} AND datetime BETWEEN '${debut}' AND '${fin}'";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByDate(User user,DateTime date) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND datetime >= date('now')";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<TransactionModel>?> getTransactionsByPeriode(User user,DateTime date_debut,DateTime date_fin) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions WHERE user_id = ${user.id} AND datetime >= '${date_debut}' AND datetime < '${date_fin}'";

    var result = await dbClient.rawQuery(sql);
    if (result.isEmpty) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<double?> getCount() async {
    var dbClient = await dbHelper.database;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM transactions")
    );
    return result!.toDouble();
  }

  Future<double?> getCountByType(String type, User user) async {
    var dbClient = await dbHelper.database;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM transactions WHERE user_id = ${user.id} AND type = '${type}'")
    );
    return result!.toDouble();
  }

  Future<double?> getCountByCat(String type, User user, CategorieModel cat) async {
    var dbClient = await dbHelper.database;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM transactions WHERE user_id = ${user.id} AND type = '${type}' AND cat_id = ${cat.id}")
    );
    return result!.toDouble();
  }

  Future<int?> getCountByTypeByCompte(String mot,User user,CompteModel compteModel) async {
    var dbClient = await dbHelper.database;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM transactions WHERE type = '${mot}' AND user_id = ${user.id} AND compte_id = ${compteModel.id}")
    );
    return result;
  }

  Future<int> updateTransaction(TransactionModel transactionModel) async {
    var dbClient = await dbHelper.database;
    var result = await dbClient.update("transactions", transactionModel.toMap(),
        where: "id = ?", whereArgs: [transactionModel.id]);
    return result;
  }

  Future getSomme(User user) async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTAL from transactions WHERE user_id = ${user.id}");
    return res.toList();
  }

  Future getSommeByType(User user,String type) async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTALTYPE from transactions WHERE user_id = ${user.id} AND type = '$type'");
    return res.toList();
  }

  Future getSommeByCat(User user,String type,CategorieModel cat) async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTALCAT from transactions WHERE user_id = ${user.id} AND type = '$type' AND cat_id = ${cat.id}");
    return res.toList();
  }

  Future<int> deleteTransaction(int? id) async {
    int result;
    var dbClient = await dbHelper.database;
    result = await dbClient.rawDelete('DELETE FROM transactions WHERE id = $id');
    return result;
  }

  ///remboursements
  Future<int> saveRemboursement(RemboursementModel remboursementModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("remboursements", remboursementModel.toMap());
    return res;
  }

  Future<List<RemboursementModel>?> getRemboursements() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM remboursements";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<RemboursementModel> list = result.map((item) {
      return RemboursementModel.fromMap(item);
    }).toList();

    return list;
  }

  Future<List<RemboursementModel>?> getRemboursementsByUser(User user) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM remboursements WHERE user_id = ${user.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<RemboursementModel> list = result.map((item) {
      return RemboursementModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<RemboursementModel>?> getRemboursementsByCompte(User user,CompteModel compte) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM remboursements WHERE user_id = ${user.id} AND compte_id = ${compte.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<RemboursementModel> list = result.map((item) {
      return RemboursementModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<RemboursementModel>?> getRemboursementsByDette(User user,DetteModel dette) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM remboursements WHERE user_id = ${user.id} AND dette_id = ${dette.id}";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<RemboursementModel> list = result.map((item) {
      return RemboursementModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<List<RemboursementModel>?> getRemboursementsByDate(User user,DateTime date) async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM remboursements WHERE user_id = ${user.id} AND datetime >= date('now')";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<RemboursementModel> list = result.map((item) {
      return RemboursementModel.fromMap(item);
    }).toList();
    return list;
  }

  Future<double?> getCountRemboursements() async {
    var dbClient = await dbHelper.database;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM remboursements")
    );
    return result!.toDouble();
  }

  Future<int> updateRemboursement(RemboursementModel remboursementModel) async {
    var dbClient = await dbHelper.database;
    var result = await dbClient.update("remboursements", remboursementModel.toMap(),
        where: "id = ?", whereArgs: [remboursementModel.id]);
    return result;
  }

  Future getRestant(User user,DetteModel dette) async {
    var dbClient = await dbHelper.database;
    var res = await dbClient.rawQuery("SELECT SUM(montant) AS TOTAL from remboursements WHERE user_id = ${user.id} AND dette_id = ${dette.id}");
    return res.toList();
  }

}