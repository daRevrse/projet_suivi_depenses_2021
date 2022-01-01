class BudgetModel {
  int? id;
  String? titre;
  String? description;
  num? montant;
  num? restant;
  DateTime? date_debut;
  DateTime? date_fin;
  int? user_id;
  int? cat_id;

  BudgetModel(
      //this.id,
      this.titre,
      this.description,
      this.montant,
      this.restant,
      this.date_debut,
      this.date_fin,
      this.user_id,
      this.cat_id,
      );

  BudgetModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.titre = obj["titre"];
    this.description = obj["description"];
    this.montant = obj["montant"];
    this.restant = obj["restant"];
    this.date_debut = DateTime.parse(obj["date_debut"]);
    this.date_fin = DateTime.parse(obj["date_fin"]);
    this.user_id = obj["user_id"];
    this.cat_id = obj["cat_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["titre"] = titre;
    map["description"] = description;
    map["montant"] = montant;
    map["restant"] = restant;
    map["date_debut"] = date_debut!.toIso8601String();
    map["date_fin"] = date_fin!.toIso8601String();
    map["user_id"] = user_id;
    map["cat_id"] = cat_id;

    return map;
  }

  //Getters
  int? get getId => id;
  String? get getTitre => titre;
  String? get getDescription => description;
  num? get getMontant => montant;
  num? get getRestant => restant;
  DateTime? get getDateDebut => date_debut;
  DateTime? get getDateFin => date_fin;
  int? get getUserId => user_id;
  int? get getCatId => cat_id;
}