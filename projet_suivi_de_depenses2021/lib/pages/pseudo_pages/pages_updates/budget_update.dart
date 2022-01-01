import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/budgetModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

DateTime dateD = DateTime.now();
DateTime dateF = DateTime.now();
//TimeOfDay time = TimeOfDay.fromDateTime(date);

class ModifierBudget extends StatefulWidget {
  final User user;
  final BudgetModel budget;
  const ModifierBudget({Key? key,required this.user,required this.budget}) : super(key: key);

  @override
  _ModifierBudget createState() => _ModifierBudget();
}

class _ModifierBudget extends State<ModifierBudget> {

  AutreOperations autreOperations = AutreOperations();
  TextEditingController controller = new TextEditingController();

  TextEditingController titreController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController dateDController = TextEditingController()..text = DateFormat.yMd().format(dateD);
  TextEditingController dateFController = TextEditingController()..text = DateFormat.yMd().format(dateF);

  late CategorieModel? cat;

  num restant = 0;

  Future checking()async{
    var _cat = await autreOperations.getCatById(widget.budget.cat_id!, widget.user);

    setState(() {
      cat = _cat;
    });

    var _trans_dep = (await autreOperations.getSommeBudget(widget.user, cat!.id!,widget.budget.date_debut!,widget.budget.date_fin!))[0]['TOTAL'];

    setState(() {
      if(_trans_dep!=null) {
        restant = widget.budget.montant! - _trans_dep;
      } else {
        restant = widget.budget.restant!;
      }
    });
  }

  @override
  void initState() {

    restant = widget.budget.restant!;

    titreController.text = widget.budget.titre!;
    descController.text = widget.budget.description!;
    montantController.text = widget.budget.montant!.toString();
    dateDController.text = DateFormat.yMd().format(widget.budget.date_debut!);
    dateFController.text = DateFormat.yMd().format(widget.budget.date_fin!);
    dateD = widget.budget.date_debut!;
    dateF = widget.budget.date_fin!;
    // TODO: implement initState
    super.initState();
  }

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
            onPressed: () async {
              //checking();
              BudgetModel budget = BudgetModel(titreController.text,descController.text,widget.budget.montant,restant,dateD,dateF,widget.user.id,widget.budget.cat_id!);
              await autreOperations.updateBudget(budget);

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> PageBudget(currentBudget: widget.budget,currentUser: widget.user,)));

            },
            child: Text("Modifier"),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 50,left: 50,right: 50),
            child:
            Column(
                children: [
                  Text("Creer un budget",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: titreController,
                      decoration: InputDecoration(
                        hintText: 'Nom du budget',
                        labelText: 'Titre',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                        onChanged: (value){
                          setState(() {
                            widget.budget.titre = value;
                          });
                        }
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: descController,
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
                        onChanged: (value){
                          setState(() {
                            widget.budget.description = value;
                          });
                        }
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: montantController,
                      decoration: InputDecoration(
                        hintText: "Montant du budget",
                        labelText: 'Montant',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            widget.budget.montant = int.parse(value);
                            checking();
                          });
                        }
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                      child: TextButton(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: dateDController,
                                decoration: InputDecoration(
                                  labelText: 'Date du début',
                                  hintText: DateFormat.yMd().format(dateD),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color:Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            //Text(DateFormat.yMd().format(date),style: TextStyle(decoration: TextDecoration.underline),),
                            Icon(Icons.calendar_today)
                          ],
                        ),

                        onPressed: (){
                          showDatePicker(
                              context: context,
                              initialDate: dateD == null ? DateTime.now() : dateD,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025)
                          ).then((value) {
                            setState(() {
                              dateD = value!;
                              dateDController.text = DateFormat.yMd().format(dateD);
                            });
                          });
                        },

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                      child: TextButton(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: dateFController,
                                decoration: InputDecoration(
                                  labelText: 'Date de Fin',
                                  hintText: DateFormat.yMd().format(dateF),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color:Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            //Text(DateFormat.yMd().format(date),style: TextStyle(decoration: TextDecoration.underline),),
                            Icon(Icons.calendar_today)
                          ],
                        ),

                        onPressed: (){
                          showDatePicker(
                              context: context,
                              initialDate: dateF == null ? DateTime.now() : dateF,
                              firstDate: dateD,
                              lastDate: DateTime(2025)
                          ).then((value) {
                            setState(() {
                              dateF = value!;
                              dateFController.text = DateFormat.yMd().format(dateF);
                            });
                          });
                        },

                      )
                  )
                ]
            )
        ),
      ),

    );
  }
}
