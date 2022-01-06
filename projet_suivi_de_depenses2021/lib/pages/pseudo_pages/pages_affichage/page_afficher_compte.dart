import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Constants/popMenuConsts.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction_via_compte.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_updates/compte_update.dart';

import '../../root_app_page.dart';

class PageCompte extends StatefulWidget {
  final CompteModel currentCompte;
  final User currentUser;
  const PageCompte({Key? key,required this.currentCompte,required this.currentUser}) : super(key: key);

  @override
  _PageCompteState createState() => _PageCompteState();
}

class _PageCompteState extends State<PageCompte> {

  TransactionOperations transactionOperations = TransactionOperations();
  CompteOperations compteOperations = CompteOperations();
  int totalRev = 0;
  int totalDep = 0;

  @override
  void initState() {
    refresh();
    // TODO: implement initState
    super.initState();

  }

  Future refresh()async{
     int _totalRev = (await transactionOperations.getCountByTypeByCompte("Revenu",widget.currentUser,widget.currentCompte))!;
     int _totalDep = (await transactionOperations.getCountByTypeByCompte("Dépense",widget.currentUser,widget.currentCompte))!;
     setState(() {
       totalRev = _totalRev;
       totalDep = _totalDep;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> RootPage(user: widget.currentUser,)));
            }, icon: Icon(Icons.arrow_back),color: Colors.white,),
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransactionViaCompte(user: widget.currentUser,compte: widget.currentCompte,)));
                },
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.settings),
                onSelected: choiceAction,
                itemBuilder: (BuildContext context){
                  return PopMenu.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Color(widget.currentCompte.color!),
                                child: Text(widget.currentCompte.nom![0],
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: Text('${widget.currentCompte.nom}',style: TextStyle(
                                fontSize: 20,
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: Text("${widget.currentCompte.montant} Fcfa",style: TextStyle(
                                fontSize: 25,
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Revenus"),
                          Text("${totalRev} Transactions",style: TextStyle(color: Colors.green),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dépenses"),
                          Text("${totalDep} Transactions",style: TextStyle(color: Colors.red),)
                        ],
                      ),
                    )
                  ],
                )
                ,
              ),
              Container(
                child: FutureBuilder<List<TransactionModel>?>(
                    future: transactionOperations.getTransactionsByCompte(widget.currentUser,widget.currentCompte),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TransactionModel>?> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                              Text("Aucune transaction",style: TextStyle(fontSize: 20,color: Colors.grey),)
                            ],
                          ),

                        ));
                      }else {
                        return snapshot.data!.isEmpty
                            ? Center(child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                              Text("Aucune transaction",style: TextStyle(fontSize: 20,color: Colors.grey),)
                            ],
                          ),

                        ))
                            : ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.map((trans) {
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.swap_horiz),
                                    title: Text('${trans.description}'),
                                    subtitle: Text('${trans.type}'),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('${trans.montant}'),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text('${trans.datetime!.day}-${trans.datetime!.month}-${trans.datetime!.year} ${trans.datetime!.hour}:${trans.datetime!.minute}'),
                                        )
                                      ],
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageAfficherTransaction(transaction: trans,currentUser: widget.currentUser,)));
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    }),
              )
            ],
          ),
        )
    );
  }

  void choiceAction(String choice){
    if(choice == PopMenu.Modifier){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ModifierCompte(compte: widget.currentCompte,user: widget.currentUser,)));
    }else if(choice == PopMenu.Supprimer){
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
        title: const Text('Supprimer ce compte?'),
        content: const Text('Etes-vous vraiment sûre?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Non'),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: ()async {
              await compteOperations.deleteCompte(widget.currentCompte.id);
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> RootPage(user: widget.currentUser,)));
            },
            child: const Text('Oui'),
          ),
        ],
      )
      );
    }
  }
}


