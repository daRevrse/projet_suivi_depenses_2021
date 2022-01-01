import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/remboursementModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_dette.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_list/page_list_transactions.dart';


DateTime date = DateTime.now();
TimeOfDay time = TimeOfDay.fromDateTime(date);

class NewRemboursement extends StatefulWidget {
  final User user;
  final DetteModel dette;
  const NewRemboursement({Key? key,required this.user,required this.dette}) : super(key: key);

  @override
  _NewRemboursement createState() => _NewRemboursement();
}

class _NewRemboursement extends State<NewRemboursement> {

  TransactionOperations transactionOperations = TransactionOperations();
  CompteOperations compteOperations = CompteOperations();
  AutreOperations autreOperations = AutreOperations();

  TextEditingController dateController = TextEditingController()..text = DateFormat.yMd().format(date);
  TextEditingController timeController = TextEditingController()..text = "${time.hour}:${time.minute}";
  TextEditingController montantController = TextEditingController();

  CompteModel? compte;
  String defaultCptHintText = "Selectionner un compte";

  @override
  void initState() {
    dateController.text = DateFormat.yMd().format(date);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Remboursement"),
        backgroundColor: Colors.teal,
      ),
      body:GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                  child: TextButton(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: dateController,
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
                          dateController.text = DateFormat.yMd().format(date);
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
                            controller: timeController,
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
                          timeController.text = "${time.hour}:${time.minute}";
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
                  controller: montantController,
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

              FutureBuilder<List<CompteModel>?>(
                  future: compteOperations.getCompteByUser(widget.user),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CompteModel>?> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return DropdownButton<CompteModel>(
                      items: snapshot.data!
                          .map((_compte) => DropdownMenuItem<CompteModel>(
                        child: Text("${_compte.nom}"),
                        value: _compte,
                      ))
                          .toList(),
                      onChanged: (CompteModel? value) {
                        setState(() {
                          compte = value;
                          defaultCptHintText = compte!.nom!;
                        });
                      },
                      isExpanded: false,
                      //value: _currentUser,
                      hint: Text('${defaultCptHintText}'),
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
                        RemboursementModel remb = RemboursementModel(date, int.parse(montantController.text), widget.user.id,compte!.id,widget.dette.id);
                        await transactionOperations.saveRemboursement(remb);

                        setState(() {
                          date = DateTime.now();
                          time = TimeOfDay.fromDateTime(date);
                          compte!.montant = (compte!.montant! - remb.montant!);
                          widget.dette.restant = (widget.dette.restant! - remb.montant!);
                        });

                        await autreOperations.updateDette(widget.dette);

                        await compteOperations.updateCompte(compte!);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> PageDette(currentUser: widget.user,currentDette: widget.dette,)));

                      },
                      child: Text("Rembourser"),)
                  ],
                ),
              )

            ],
          ),
        ),
      ),

    );
  }
}
