class User {
  int? id;
  final String nom;

  User({this.id, required this.nom});

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    nom: map['nom'],
  );

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'nom': nom,
    };
  }
}