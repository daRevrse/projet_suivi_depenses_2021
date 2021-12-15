import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_list/page_list_transactions.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  _NewTransaction createState() => _NewTransaction();
}

class _NewTransaction extends State<NewTransaction> {

  TransactionOperations transactionOperations = TransactionOperations();

  TextEditingController titreDController = TextEditingController();
  TextEditingController descDController = TextEditingController();
  TextEditingController montantDController = TextEditingController();

  TextEditingController titreRController = TextEditingController();
  TextEditingController descRController = TextEditingController();
  TextEditingController montantRController = TextEditingController();


  List ListItem =['Item 1','Item 2','Item 3','Item 4'];
  String valuechoose = "Item 1";
  String valueNew = "valuechoose";

        @override
        Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(title: Text("Nouvelle transaction"),
            backgroundColor: Colors.teal,
            /*actions: [
              RaisedButton(
                color: Colors.white,
                onPressed: () async {
                  TransactionModel trans = TransactionModel("Titre", descController.text, montantController.text, "Dépense");
                  await transactionOperations.saveTransaction(trans);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ListeTransactions()));

                },
                child: Text("Enregistrer"),
              )
            ],*/
            bottom: TabBar(
              tabs:[
                Tab(text: 'Ajouter Revenue'),
                Tab(text:'Ajouter Depense')
              ],

            ),
          ),
          body:GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Enregistrement de Revenue",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),

                          /*Padding(
                            padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child: DropdownButton(
                              hint:Text('Selectionner la categorie'),
                              value: valuechoose,
                              iconSize: 36,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.black
                              ),
                              isExpanded:true,
                              onChanged: (value) { setState(() {
                                valuechoose = value.toString();
                              });
                              },
                              items: ListItem.map((valueItem){
                                return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem)
                                );
                              }).toList(),
                            ),
                          ),*/

                          Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              controller: titreRController,
                              decoration: InputDecoration(
                                labelText: 'Titre',

                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              controller: descRController,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                labelText: 'Description',

                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),),
                          Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              controller: montantRController,
                              decoration: InputDecoration(
                                hintText: 'CFA',
                                labelText: 'Montant',

                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),),
                         /* Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Selectionner un compte',
                                labelText: 'Portefeuille',

                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),),*/

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Annuler"),),
                                Container(width: 30,),
                                ElevatedButton(
                                  onPressed: () async {
                                    TransactionModel trans = TransactionModel(titreRController.text, descRController.text, int.parse(montantRController.text), "Revenu");
                                    await transactionOperations.saveTransaction(trans);

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ListeTransactions()));

                                  },
                                  child: Text("Enregistrer"),)
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Enregistrement de Dépense",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          /* Padding(
                          padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                          child: DropdownButton(
                            hint:Text('Selectionner la categorie'),
                            value: valuechoose,
                            iconSize: 36,
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.black
                            ),
                            isExpanded:true,
                            onChanged: (value) { setState(() {
                              valuechoose = value.toString();
                            });
                            },
                            items: ListItem.map((valueItem){
                              return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem)
                              );
                            }).toList(),
                          ),
                        ),*/
                          Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              controller: titreDController,
                              decoration: InputDecoration(
                                labelText: 'Titre',

                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              controller: descDController,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),),
                          Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child:
                            TextField(
                              controller: montantDController,
                              decoration: InputDecoration(
                                hintText: 'CFA',
                                labelText: 'Montant',

                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color:Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Annuler"),),
                                Container(width: 30,),
                                ElevatedButton(
                                  onPressed: () async {
                                    TransactionModel trans = TransactionModel(titreDController.text, descDController.text, int.parse(montantDController.text), "Dépense");
                                    await transactionOperations.saveTransaction(trans);

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ListeTransactions()));

                                  },
                                  child: Text("Enregistrer"),)
                              ],
                            ),
                          )

                        ],
                      ),
                    ),),
                ]
            ),
          ),

        ),

      );

    }
  }
