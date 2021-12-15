class CompteModel {
  String? nom;
  String? description;
  num? montant;
  //String? type;

  CompteModel(
      this.nom,
      this.description,
      this.montant,
      //this.type,
      );

  CompteModel.fromMap(dynamic obj) {
    this.nom = obj["nom"];
    this.description = obj["description"];
    this.montant = obj["montant"];
    //this.type = obj["type"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["nom"] = nom;
    map["description"] = description;
    map["montant"] = montant;
    //map["type"] = type;

    return map;
  }

  //Getters
  String? get getNom => nom;
  String? get getDescription => description;
  num? get getMontant => montant;
  //String? get getType => type;
}