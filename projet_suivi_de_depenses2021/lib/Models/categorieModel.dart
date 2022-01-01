import 'dart:ui';

class CategorieModel {
  int? id;
  String? nom;
  String? type;
  int? color;
  int? user_id;

  CategorieModel(
      //this.id,
      this.nom,
      this.type,
      this.color,
      this.user_id,
      );

  CategorieModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.nom = obj["nom"];
    this.type = obj["type"];
    this.color = obj["color"];
    this.user_id = obj["user_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["nom"] = nom;
    map["type"] = type;
    map["color"] = color;
    map["user_id"] = user_id;

    return map;
  }

  //Getters
  int? get getId => id;
  String? get getNom => nom;
  String? get getType => type;
  int? get getColor => color;
  int? get getUserId => user_id;
}