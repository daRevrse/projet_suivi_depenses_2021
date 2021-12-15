import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModifierCompte extends StatefulWidget {
  const ModifierCompte({Key? key}) : super(key: key);

  @override
  _ModifierCompte createState() => _ModifierCompte();
}

class _ModifierCompte extends State<ModifierCompte> {

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Compte"),
        backgroundColor: Colors.teal,
        actions: [
          RaisedButton(
            elevation: 10,
            color: Colors.white,
            onPressed: (){},
            child: Text("Enregistrer"
            ),
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
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  TextField(
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
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  TextField(
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
                  ),
                ),
              ]
          )
      ),

    );
  }
}
