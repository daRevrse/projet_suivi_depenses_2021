class TransactionModel {
  int? id;
  DateTime? datetime;
  String? description;
  num? montant;
  String? type;
  int? user_id;
  int? compte_id;
  int? cat_id;

  TransactionModel(
      this.datetime,
      this.description,
      this.montant,
      this.type,
      this.user_id,
      this.compte_id,
      this.cat_id,
      );

  TransactionModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.datetime = DateTime.parse(obj["datetime"]);
    this.description = obj["description"];
    this.montant = obj["montant"];
    this.type = obj["type"];
    this.user_id = obj["user_id"];
    this.compte_id = obj["compte_id"];
    this.cat_id = obj["cat_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["datetime"] = datetime!.toIso8601String();
    map["description"] = description;
    map["montant"] = montant;
    map["type"] = type;
    map["user_id"] = user_id;
    map["compte_id"] = compte_id;
    map["cat_id"] = cat_id;

    return map;
  }

  //Getters
  int? get getId => id;
  DateTime? get getdatetime => datetime;
  String? get getDescription => description;
  num? get getMontant => montant;
  String? get getType => type;
  int? get getUserId => user_id;
  int? get getCompteId => compte_id;
  int? get getCatId => cat_id;
}