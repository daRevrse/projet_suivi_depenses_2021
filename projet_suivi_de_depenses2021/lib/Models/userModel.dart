class User {
  int? id;
  String? nom;

  User(
      this.nom,
      );

  User.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.nom = obj["nom"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["nom"] = nom;

    return map;
  }

  //Getters
  int? get getId => id;
  String? get getNom => nom;
}