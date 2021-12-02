//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Portefeuille extends StatefulWidget {
  const Portefeuille({Key? key}) : super(key: key);

  @override
  _PortefeuilleState createState() => _PortefeuilleState();
}

class _PortefeuilleState extends State<Portefeuille> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(title: FittedBox(child: Text("Nom de l'utilisateur"),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30),
            backgroundColor: Colors.teal,
            //actions: [IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal,
                child: Text("Portefeuille",style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            )
        ),
      ),
        backgroundColor: Colors.grey[300],
        body: Container(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                elevation: 5,
                child: Container(
                  //height: screenSize.height / 2,
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.home),
                                title: Text("Titre"),
                                subtitle: Text("montant"),
                                trailing: Icon(Icons.add),
                                tileColor: Colors.blueAccent,
                              ),
                            ),

                            Card(
                              child: ListTile(
                                leading: Icon(Icons.home),
                                title: Text("Titre"),
                                subtitle: Text("montant"),
                                trailing: Icon(Icons.add),
                                tileColor: Colors.greenAccent,
                              ),
                            ),

                            Card(
                              child: ListTile(
                                leading: Icon(Icons.home),
                                title: Text("Titre"),
                                subtitle: Text("montant"),
                                trailing: Icon(Icons.add),
                                tileColor: Colors.redAccent,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                width: screenSize.width,
                height: screenSize.height / 10,
                child: TextButton(
                  style: ButtonStyle(
                    shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: Colors.grey,width: 4),
                        )
                    ),
                  ),
                  onPressed: (){},
                  child: Icon(Icons.add,color: Colors.grey,size: 50,),
                ),
              ),
            ],
          ),
        ),


            );
  }
}
