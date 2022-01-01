import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_compte.dart';

class ModifierCompte extends StatefulWidget {
  final CompteModel compte;
  final User user;
  const ModifierCompte({Key? key,required this.compte,required this.user}) : super(key: key);

  @override
  _ModifierCompte createState() => _ModifierCompte();
}

class _ModifierCompte extends State<ModifierCompte> {

  TextEditingController controller = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  CompteOperations compteOperations = CompteOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Compte"),
        backgroundColor: Colors.teal,
        actions: [
          RaisedButton(
            elevation: 10,
            color: Colors.white,
            onPressed: ()async{
              await compteOperations.updateCompte(widget.compte).whenComplete(() =>
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context)=>
                              PageCompte(currentCompte: widget.compte,currentUser: widget.user,))));
            },
            child: Text("Enregistrer"),
          )

        ],
      ),
      body:
      Padding(padding: EdgeInsets.only(top: 50,left: 50,right: 50),
          child:
          Column(
              children: [

                Text("Modifier le compte",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  TextField(
                    controller: nomController,
                    decoration: InputDecoration(
                      hintText: 'entrer le nouveau nom',
                      labelText: 'Nouveau nom ',

                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (value){
                      //nomController.text = value;
                      setState(() {
                        widget.compte.nom = value;
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: 'Nouvelle Description',
                      labelText: 'Description',

                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (value){
                      //descController.text = value;
                      setState(() {
                        widget.compte.description = value;
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  TextField(
                    controller: montantController,
                    decoration: InputDecoration(
                      hintText: 'Entrer le nouveau montant',
                      labelText: 'Nouveau montant',

                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      //montantController.text = value;
                      setState(() {
                        widget.compte.montant = int.parse(value);
                      });
                    },
                  ),
                ),
              ]
          )
      ),

    );
  }
}
