class TransactionModel {
  String? titre;
  String? description;
  num? montant;
  String? type;

  TransactionModel(
      this.titre,
      this.description,
      this.montant,
      this.type,
      );

  TransactionModel.fromMap(dynamic obj) {
    this.titre = obj["titre"];
    this.description = obj["description"];
    this.montant = obj["montant"];
    this.type = obj["type"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["titre"] = titre;
    map["description"] = description;
    map["montant"] = montant;
    map["type"] = type;

    return map;
  }

  //Getters
  String? get getTitre => titre;
  String? get getDescription => description;
  num? get getMontant => montant;
  String? get getType => type;
}