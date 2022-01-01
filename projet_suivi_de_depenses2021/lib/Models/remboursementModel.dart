class RemboursementModel {
  int? id;
  DateTime? datetime;
  num? montant;
  int? user_id;
  int? compte_id;
  int? dette_id;

  RemboursementModel(
      this.datetime,
      this.montant,
      this.user_id,
      this.compte_id,
      this.dette_id,
      );

  RemboursementModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.datetime = DateTime.parse(obj["datetime"]);
    this.montant = obj["montant"];
    this.user_id = obj["user_id"];
    this.compte_id = obj["compte_id"];
    this.dette_id = obj["dette_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["datetime"] = datetime!.toIso8601String();
    map["montant"] = montant;
    map["user_id"] = user_id;
    map["compte_id"] = compte_id;
    map["dette_id"] = dette_id;

    return map;
  }

  //Getters
  int? get getId => id;
  DateTime? get getdatetime => datetime;
  num? get getMontant => montant;
  int? get getUserId => user_id;
  int? get getCompteId => compte_id;
  int? get getDetteId => dette_id;
}