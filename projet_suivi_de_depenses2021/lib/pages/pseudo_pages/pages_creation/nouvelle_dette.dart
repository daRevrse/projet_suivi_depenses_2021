import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDette extends StatefulWidget {
  const NewDette({Key? key}) : super(key: key);

  @override
  _NewDette createState() => _NewDette();
}

class _NewDette extends State<NewDette> {

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Dette"),
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
            padding: EdgeInsets.only(top: 50,left: 50,right: 50),
            child:
            Column(
                children: [

                  Text("Enregistrer une dette",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Nom de la personne',
                        labelText: 'Je dois a ....',

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
                        hintText: 'Description',
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
                        hintText: 'Montant',
                        labelText: 'La somme de...',

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
      ),

    );
  }
}
