import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBudget extends StatefulWidget {
  const NewBudget({Key? key}) : super(key: key);

  @override
  _NewBudget createState() => _NewBudget();
}

class _NewBudget extends State<NewBudget> {

  TextEditingController controller = new TextEditingController();
  List ListItem =['Item 1','Item 2','Item 3','Item 4'];
  late String valuechoose='Item 1';
  late String valueNew;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Budget"),
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

                Text("Ajouter un budget",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Nom du budget',
                      labelText: 'Nom',

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
                      hintText: 'Entrer le montant',
                      labelText: 'Montant',

                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: DropdownButton(
                    hint:Text('Selectionner la categorie'),
                    value:valuechoose,
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.black
                    ),
                    isExpanded:true,
                    onChanged: (valueNew) { setState(() {
                      this.valuechoose= this.valueNew;
                    });
                    },
                    items: ListItem.map((valueItem){
                      return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem)
                      );
                    }).toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: DropdownButton(
                    hint:Text('Selectionner la periode'),
                    value:valuechoose,
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.black
                    ),
                    isExpanded:true,
                    onChanged: (valueNew) { setState(() {
                      this.valuechoose= this.valueNew;
                    });
                    },
                    items: ListItem.map((valueItem){
                      return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem)
                      );
                    }).toList(),
                  ),
                ),


              ]
          )
      ),

    );
  }
}
