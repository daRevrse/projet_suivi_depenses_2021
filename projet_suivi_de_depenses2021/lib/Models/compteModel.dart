class CompteModel {
  int? id;
  String? nom;
  String? description;
  num? montant;
  int? color;
  int? user_id;

  CompteModel(
      //this.id,
      this.nom,
      this.description,
      this.montant,
      this.color,
      this.user_id,
      );

  CompteModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.nom = obj["nom"];
    this.description = obj["description"];
    this.montant = obj["montant"];
    this.color = obj["color"];
    this.user_id = obj["user_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["nom"] = nom;
    map["description"] = description;
    map["montant"] = montant;
    map["color"] = color;
    map["user_id"] = user_id;

    return map;
  }

  //Getters
  int? get getId => id;
  String? get getNom => nom;
  String? get getDescription => description;
  num? get getMontant => montant;
  int? get getColor => color;
  int? get getUserId => user_id;
}