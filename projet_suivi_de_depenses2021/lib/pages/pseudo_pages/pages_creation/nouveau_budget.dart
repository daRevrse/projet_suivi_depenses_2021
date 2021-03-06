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
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

DateTime dateD = DateTime.now();
DateTime dateF = DateTime.now();
//TimeOfDay time = TimeOfDay.fromDateTime(date);

class NewBudget extends StatefulWidget {
  final User user;
  const NewBudget({Key? key,required this.user}) : super(key: key);

  @override
  _NewBudget createState() => _NewBudget();
}

class _NewBudget extends State<NewBudget> {

  AutreOperations autreOperations = AutreOperations();
  TextEditingController controller = new TextEditingController();

  TextEditingController titreController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController dateDController = TextEditingController()..text = DateFormat.yMd().format(dateD);
  TextEditingController dateFController = TextEditingController()..text = DateFormat.yMd().format(dateF);

  CategorieModel? categorie;
  String defaultCatHintText = "Selectionner une catégorie";

  @override
  void initState() {
    dateDController.text = DateFormat.yMd().format(dateD);
    dateFController.text = DateFormat.yMd().format(dateF);
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
              BudgetModel budget = BudgetModel(titreController.text,descController.text,int.parse(montantController.text),int.parse(montantController.text),dateD,dateF,widget.user.id,categorie!.id);
              await autreOperations.saveBudget(budget);

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> RootPage(user: widget.user,)));

            },
            child: Text("Enregistrer"),
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
                  ),
                  FutureBuilder<List<CategorieModel>?>(
                      future: autreOperations.getCatByType("Dépense",widget.user),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CategorieModel>?> snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();
                        return DropdownButton<CategorieModel>(
                          items: snapshot.data!
                              .map((_cat) => DropdownMenuItem<CategorieModel>(
                            child: Text("${_cat.nom}"),
                            value: _cat,
                          ))
                              .toList(),
                          onChanged: (CategorieModel? value) {
                            setState(() {
                              categorie = value;
                              defaultCatHintText = categorie!.nom!;
                            });
                          },
                          isExpanded: false,
                          //value: _currentUser,
                          hint: Text('${defaultCatHintText}'),
                          dropdownColor: Colors.white,
                        );
                      }),
                ]
            )
        ),
      ),

    );
  }
}
