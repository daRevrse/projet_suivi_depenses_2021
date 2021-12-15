import 'package:projet_suivi_de_depenses2021/Database/database_helper.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';

class TransactionOperations{
  late TransactionOperations transactionOperations;

  final dbHelper = DatabaseHelper.instance;

  Future<int> saveTransaction(TransactionModel transactionModel) async {
    var dbClient = await dbHelper.database;
    int res = await dbClient.insert("transactions", transactionModel.toMap());
    return res;
  }

  Future<List<TransactionModel>?> getTransactionModelData() async {
    var dbClient = await dbHelper.database;
    String sql;
    sql = "SELECT * FROM transactions";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<TransactionModel> list = result.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();

    print(result);
    return list;
  }

}