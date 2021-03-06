import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_compte.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_list/page_list_transactions.dart';


DateTime date = DateTime.now();
TimeOfDay time = TimeOfDay.fromDateTime(date);

class NewTransactionViaCompte extends StatefulWidget {
  final User user;
  final CompteModel compte;
  const NewTransactionViaCompte({Key? key,required this.user,required this.compte}) : super(key: key);

  @override
  _NewTransactionViaCompte createState() => _NewTransactionViaCompte();
}

class _NewTransactionViaCompte extends State<NewTransactionViaCompte> {

  TransactionOperations transactionOperations = TransactionOperations();
  CompteOperations compteOperations = CompteOperations();
  AutreOperations autreOperations = AutreOperations();

  TextEditingController dateDController = TextEditingController()..text = DateFormat.yMd().format(date);
  TextEditingController timeDController = TextEditingController()..text = "${time.hour}:${time.minute}";
  TextEditingController descDController = TextEditingController();
  TextEditingController montantDController = TextEditingController();

  TextEditingController dateRController = TextEditingController()..text = DateFormat.yMd().format(date);
  TextEditingController timeRController = TextEditingController()..text = "${time.hour}:${time.minute}";
  TextEditingController descRController = TextEditingController();
  TextEditingController montantRController = TextEditingController();

  CompteModel? compte;
  CategorieModel? categorie;
  String defaultCatRHintText = "Selectionner une cat??gorie";
  String defaultCatDHintText = "Selectionner une cat??gorie";

  @override
  void initState() {
    dateRController.text = DateFormat.yMd().format(date);
    dateDController.text = DateFormat.yMd().format(date);

    setState(() {
      compte = widget.compte;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(title: Text("Nouvelle transaction"),
          backgroundColor: Colors.teal,
          bottom: TabBar(
            tabs:[
              Tab(text: 'Ajouter Revenu'),
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
                          child: Text("Enregistrement de Revenu",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child: TextButton(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: dateRController,
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        hintText: DateFormat.yMd().format(date),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color:Colors.black,
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  //Text(DateFormat.yMd().format(date),style: TextStyle(decoration: TextDecoration.underline),),
                                  Icon(Icons.calendar_today)
                                ],
                              ),

                              onPressed: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: date == null ? DateTime.now() : date,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now()
                                ).then((value) {
                                  setState(() {
                                    date = value!;
                                    dateRController.text = DateFormat.yMd().format(date);
                                  });
                                });
                              },

                            )
                        ),

                        Padding(padding: EdgeInsets.only(left: 50,right: 50),
                            child: TextButton(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: timeRController,
                                      decoration: InputDecoration(
                                        labelText: 'Heure',
                                        hintText: "${date.hour}:${date.minute}",
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color:Colors.black,
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  //Text(DateFormat.yMd().format(date),style: TextStyle(decoration: TextDecoration.underline),),
                                  Icon(Icons.alarm)
                                ],
                              ),

                              onPressed: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: time,
                                ).then((value) {
                                  setState(() {
                                    time = value!;
                                    timeRController.text = "${time.hour}:${time.minute}";
                                    DateTime _date = new DateTime(date.year, date.month, date.day, time.hour, time.minute);
                                    date = _date;
                                  });
                                });
                              },

                            )
                        ),

                        Padding(padding: EdgeInsets.only(top: 15,left: 50,right: 50),
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
                          ),
                        ),

                        FutureBuilder<List<CategorieModel>?>(
                            future: autreOperations.getCatByType("Revenu",widget.user),
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
                                    defaultCatRHintText = categorie!.nom!;
                                  });
                                },
                                isExpanded: false,
                                //value: _currentUser,
                                hint: Text('${defaultCatRHintText}'),
                                dropdownColor: Colors.white,
                              );
                            }),

                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (){

                                  setState(() {
                                    date = DateTime.now();
                                    time = TimeOfDay.fromDateTime(date);
                                  });

                                  Navigator.of(context).pop();
                                },
                                child: Text("Annuler"),),
                              Container(width: 30,),
                              ElevatedButton(
                                onPressed: () async {
                                  TransactionModel trans = TransactionModel(date, descRController.text, int.parse(montantRController.text), "Revenu",widget.user.id,widget.compte.id,categorie!.id);
                                  await transactionOperations.saveTransaction(trans);

                                  setState(() {
                                    date = DateTime.now();
                                    time = TimeOfDay.fromDateTime(date);
                                    compte!.montant = (compte!.montant! + int.parse(montantRController.text));
                                  });

                                  await compteOperations.updateCompte(compte!);

                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> PageCompte(currentUser: widget.user,currentCompte: widget.compte,)));

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
                          child: Text("Enregistrement de D??pense",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                            child: TextButton(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: dateDController,
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        hintText: DateFormat.yMd().format(date),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color:Colors.black,
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  //Text(DateFormat.yMd().format(date),style: TextStyle(decoration: TextDecoration.underline),),
                                  Icon(Icons.calendar_today)
                                ],
                              ),

                              onPressed: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: date == null ? DateTime.now() : date,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now()
                                ).then((value) {
                                  setState(() {
                                    date = value!;
                                    dateDController.text = DateFormat.yMd().format(date);
                                  });
                                });
                              },

                            )
                        ),

                        Padding(padding: EdgeInsets.only(left: 50,right: 50),
                            child: TextButton(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: timeDController,
                                      decoration: InputDecoration(
                                        labelText: 'Heure',
                                        hintText: "${date.hour}:${date.minute}",
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color:Colors.black,
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Icon(Icons.alarm)
                                ],
                              ),

                              onPressed: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: time,
                                ).then((value) {
                                  setState(() {
                                    time = value!;
                                    timeDController.text = "${time.hour}:${time.minute}";
                                    DateTime _date = new DateTime(date.year, date.month, date.day, time.hour, time.minute);
                                    date = _date;
                                  });
                                });
                              },

                            )
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
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        FutureBuilder<List<CategorieModel>?>(
                            future: autreOperations.getCatByType("D??pense",widget.user),
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
                                    defaultCatDHintText = categorie!.nom!;
                                  });
                                },
                                isExpanded: false,
                                //value: _currentUser,
                                hint: Text('${defaultCatDHintText}'),
                                dropdownColor: Colors.white,
                              );
                            }),

                        Padding(
                          padding: const EdgeInsets.only(top:50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    date = DateTime.now();
                                    time = TimeOfDay.fromDateTime(date);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text("Annuler"),),
                              Container(width: 30,),
                              ElevatedButton(
                                onPressed: () async {
                                  TransactionModel trans = TransactionModel(date, descDController.text, int.parse(montantDController.text), "D??pense",widget.user.id,widget.compte.id,categorie!.id);
                                  await transactionOperations.saveTransaction(trans);

                                  setState(() {
                                    date = DateTime.now();
                                    time = TimeOfDay.fromDateTime(date);
                                    compte!.montant = (compte!.montant! - trans.montant!);
                                  });

                                  await compteOperations.updateCompte(compte!);

                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> PageCompte(currentUser: widget.user,currentCompte: widget.compte,)));

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
