import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_list/page_list_transactions.dart';

class PageAfficherTransaction extends StatefulWidget {
  final TransactionModel transaction;
  final User currentUser;
  const PageAfficherTransaction({Key? key,required this.transaction,required this.currentUser}) : super(key: key);

  @override
  _PageAfficherTransactionState createState() => _PageAfficherTransactionState();
}

class _PageAfficherTransactionState extends State<PageAfficherTransaction> {

  TransactionOperations transactionOperations = TransactionOperations();
  AutreOperations autreOperations = AutreOperations();
  CompteOperations compteOperations = CompteOperations();

  late CategorieModel? cat;
  late CompteModel? cpt;

  Future checking()async{
    var _cat = await autreOperations.getCatById(widget.transaction.cat_id!, widget.currentUser);
    var _cpt = await compteOperations.getCompteById(widget.transaction.compte_id!);

    setState(() {
      cat = _cat;
      cpt = _cpt;
    });

  }

  @override
  void initState() {
    checking();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.teal,
          actions: [
            /*IconButton(
              icon: Icon(Icons.mode),
              onPressed: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransaction()));
              },
            ),*/
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                setState(() {
                  if(widget.transaction.type == "Dépense"){
                    cpt!.montant = (cpt!.montant! + widget.transaction.montant!);
                  }else{
                    cpt!.montant = (cpt!.montant! - widget.transaction.montant!);
                  }
                  compteOperations.updateCompte(cpt!);
                });
                await transactionOperations.deleteTransaction(widget.transaction.id);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => ListeTransactions(user: widget.currentUser,periode: "Tous",)));

              },
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description),
                  Text(widget.transaction.description.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date :"),
                  Text(DateFormat.yMMMMd("fr_FR").format(widget.transaction.datetime!))
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Heure :"),
                  Text("${widget.transaction.datetime!.hour} : ${widget.transaction.datetime!.minute}")
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Montant :"),
                  Text(widget.transaction.montant.toString())
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Type :"),
                  Text(widget.transaction.type.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Catégorie :"),
                  Text(cat!.nom.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Compte :"),
                  Text(cpt!.nom.toString())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
