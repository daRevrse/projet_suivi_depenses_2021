import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_compte.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_dette.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_updates/compte_update.dart';

class PagePortefeuille extends StatefulWidget {
  final String userName;
  const PagePortefeuille({Key? key,required this.userName}) : super(key: key);

  @override
  _PagePortefeuilleState createState() => _PagePortefeuilleState();
}

class _PagePortefeuilleState extends State<PagePortefeuille> {

  CompteOperations compteOperations = CompteOperations();

  List<CompteModel> listCateg = [];

  getComptes()async{
     listCateg = (await compteOperations.getCompteModelData())!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComptes();
  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
            automaticallyImplyLeading: false,
            title: FittedBox(child: Text('${widget.userName}'),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal,
            actions: [IconButton(padding: EdgeInsets.only(right: 20,top: 10),onPressed: (){}, icon: Icon(Icons.view_list,size: 40,))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal[800],
                child: Text("Portefeuille",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            )
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(10),
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      children: [...listCateg,null].map((item) {
                        if(item == null){
                          return Card(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 3,
                              ),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  /*border: Border.all(
                                      width: 2,
                                      color: activeCategory == index
                                          ? primary
                                          : Colors.transparent),*/
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.01),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              width: 100,
                              height: 100,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(color: Colors.teal,width: 4),
                                      )
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewCompte()));
                                },
                                child: Icon(Icons.add,color: Colors.teal,size: 50,),
                              ),
                            ),
                          );
                        }
                        return Card(
                            child: Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  /*border: Border.all(
                                      width: 2,
                                      color: activeCategory == index
                                          ? primary
                                          : Colors.transparent),*/
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.01),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 5, top: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.withOpacity(0.15)),
                                        ),
                                        Text('${item.nom}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text('${item.montant}',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ModifierCompte()));
                                        }, icon: Icon(Icons.mode_sharp))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }
                      ).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      child: Text("Budgets",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      padding: EdgeInsets.only(top: 5,bottom: 10,left: 10),
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewBudget()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.add,color: Colors.teal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("Ajouter un budget",style: TextStyle(color: Colors.teal),),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      child: Text("Dettes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      padding: EdgeInsets.only(top: 5,bottom: 10,left: 10),
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      ),
                  ],
                ),
              ),

              SizedBox(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewDette()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.add,color: Colors.teal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("Ajouter une dette",style: TextStyle(color: Colors.teal),),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}

