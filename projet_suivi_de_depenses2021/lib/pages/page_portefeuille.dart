import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/dette_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/budgetModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_compte.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_dette.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_compte.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_dette.dart';
import 'package:percent_indicator/percent_indicator.dart';
class PagePortefeuille extends StatefulWidget {
  final User currentUser;
  const PagePortefeuille({Key? key,required this.currentUser}) : super(key: key);

  @override
  _PagePortefeuilleState createState() => _PagePortefeuilleState();
}

class _PagePortefeuilleState extends State<PagePortefeuille> {

  CompteOperations compteOperations = CompteOperations();
  AutreOperations autreOperations = AutreOperations();
  DetteOperations detteOperations = DetteOperations();

  List<CompteModel> listComptes = [];
  List<DetteModel> listDettes = [];
  List<BudgetModel> listBudgets = [];


  getListes()async{
    var _listComptes = await compteOperations.getCompteByUser(widget.currentUser);
    var _listBudgets = await autreOperations.getBudgetsByUser(widget.currentUser);
    var _listDettes = await detteOperations.getDettesByUser(widget.currentUser);


    setState(() {
      listComptes = _listComptes!;
      listBudgets = _listBudgets!;
      listDettes = _listDettes!;

    });
  }

  @override
  void initState() {
    getListes();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
            automaticallyImplyLeading: false,
            title: FittedBox(child: Text('${widget.currentUser.nom}'),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal,
            //actions: [IconButton(padding: EdgeInsets.only(right: 20,top: 10),onPressed: (){}, icon: Icon(Icons.view_list,size: 40,))],
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
              SingleChildScrollView(
                child: Container(
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
                        children: [...listComptes,null].map((item) {
                          if(item == null){
                            return Card(
                              elevation: 0,
                              color: Colors.grey[300],
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(color: Colors.grey[300],),
                                width: 100,
                                height: 100,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.teal,width: 4),
                                        )
                                    ),
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewCompte(user: widget.currentUser,)));
                                  },
                                  child: Icon(Icons.add,color: Colors.teal,size: 50,),
                                ),
                              ),
                            );
                          }
                          return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  //width: 80,
                                  //height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      /*border: Border.all(
                                          width: 2,
                                          color: activeCategory == index
                                              ? primary
                                              : Colors.transparent),*/
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.01),
                                          spreadRadius: 10,
                                          blurRadius: 3,
                                          // changes position of shadow
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        /*Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.deepPurple),
                                        ),*/
                                        Text('${item.nom}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Container(
                                          //width: 60,
                                          child: AutoSizeText('${item.montant} Fcfa',
                                            //style: TextStyle(fontSize: 20,),
                                            presetFontSizes: [15,10,5],
                                            maxLines: 2,
                                          ),
                                        ),
                                        IconButton(onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageCompte(currentCompte: item,currentUser: widget.currentUser,)));
                                        }, icon: Icon(Icons.visibility))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            color: Color(item.color!),
                          );
                        }
                        ).toList(),
                      ),
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
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [...listBudgets,null].map((budget) {
                  if(budget == null)
                    return Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewBudget(user: widget.currentUser)));
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
                    );

                  double percent = 0.0;

                  setState(() {
                    percent = ((budget.restant! * 100) / budget.montant!).floorToDouble();
                    percent < 0.0 ? percent = 0.0 : percent = percent;
                  });

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageBudget(currentBudget: budget,currentUser: widget.currentUser,)));
                        },
                        leading: CircularPercentIndicator(
                          radius: 42.0,
                          lineWidth: 5.0,
                          animation: true,
                          percent: percent / 100,
                          center: Text(
                            "${percent.toInt()}%",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
                          ),
                          /*footer: Text(
                            "Utilisation",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
                          ),*/
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.teal,
                        ),
                        title: Text("${budget.titre}"),
                        subtitle: Text("${budget.description}"),
                        trailing: Text("${budget.montant}"),
                      ),
                    ),
                  );
                }).toList(),
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
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [...listDettes,null].map((_det) {
                  if(_det == null) {
                    setState(() {

                    });
                    return Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewDette(user: widget.currentUser)));
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
                    );
                  }else {
                    return Container(
                    color: Colors.white,
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageDette(currentDette: _det,currentUser: widget.currentUser,)));
                      },
                      leading: CircleAvatar(child: Text("${_det.creancier![0]}"),),
                      title: Text("${_det.creancier}"),
                      subtitle: Text("${_det.description}"),
                      trailing: Text("${_det.montant}"),
                    ),
                  );
                  }
                }).toList(),
              ),
            ],
          ),
        ),
      ),


    );
  }
}

