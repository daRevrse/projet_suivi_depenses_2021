import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class categorie extends StatefulWidget {
  const categorie({Key? key}) : super(key: key);

  @override
  _categorie createState() => _categorie();
}

class _categorie extends State<categorie> {

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Categorie"),
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
      body: SingleChildScrollView(
        child:
        DefaultTabController(
          length: 2,
          child:
          Padding(padding: EdgeInsets.only(top: 50,left: 50,right: 50),
              child:
              Column(
                  children: [

                    Text("Enregistrer une categorie",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 25),
                      child:
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Nom de la categorie',
                          labelText: 'Entrer le nom',

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
                          hintText: 'Type de categorie',
                          labelText: 'Depense ou revenue',

                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 25, bottom: 25),
                      child:
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Icon',
                          labelText: 'Ajouter une icon',

                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadiusDirectional.circular(10)
                        ),

                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBar(
                              indicator: BoxDecoration(color: Colors.teal,
                                  borderRadius: BorderRadiusDirectional.circular(10)
                              ),
                              tabs:[
                                Tab(text:'Revenue'),
                                Tab(text:'Depense'),
                              ]
                          ),
                        )
                    ),
                    SizedBox(
                        height: 300,
                        child:TabBarView(
                          children: [
                            Container(
                                height:100,
                                width:100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.circular(10)
                                ),
                                child:
                                Text('Revenue')
                            ),
                            Container(
                                height:100,
                                width:100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.circular(10)
                                ),
                                child:
                                Text('Depense')
                            )
                          ],
                        )
                    ),

                  ]
              )
          ),

        ),
      ),
    );
  }
}
