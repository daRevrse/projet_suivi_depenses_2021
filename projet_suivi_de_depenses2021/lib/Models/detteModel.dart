class DetteModel {
  int? id;
  String? creancier;
  String? description;
  num? montant;
  num? restant;
  DateTime? datetime;
  int? user_id;

  DetteModel(
      //this.id,
      this.creancier,
      this.description,
      this.montant,
      this.restant,
      this.datetime,
      this.user_id,
      );

  DetteModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.creancier = obj["creancier"];
    this.description = obj["description"];
    this.montant = obj["montant"];
    this.restant = obj["restant"];
    this.datetime = DateTime.parse(obj["datetime"]);
    this.user_id = obj["user_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["creancier"] = creancier;
    map["description"] = description;
    map["montant"] = montant;
    map["restant"] = restant;
    map["datetime"] = datetime!.toIso8601String();
    map["user_id"] = user_id;

    return map;
  }

  //Getters
  int? get getId => id;
  String? get getCreancier => creancier;
  String? get getDescription => description;
  num? get getMontant => montant;
  num? get getRestant => restant;
  DateTime? get getDatetime => datetime;
  int? get getUserId => user_id;
}