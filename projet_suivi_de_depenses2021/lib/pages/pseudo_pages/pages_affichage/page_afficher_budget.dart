import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projet_suivi_de_depenses2021/Constants/popMenuConsts.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/budgetModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_updates/budget_update.dart';
import '../../root_app_page.dart';

class PageBudget extends StatefulWidget {
  final BudgetModel currentBudget;
  final User currentUser;
  const PageBudget({Key? key,required this.currentBudget,required this.currentUser}) : super(key: key);

  @override
  _PageBudgetState createState() => _PageBudgetState();
}

class _PageBudgetState extends State<PageBudget> {

  TransactionOperations transactionOperations = TransactionOperations();
  AutreOperations autreOperations = AutreOperations();

  late CategorieModel? cat;

  double _percent = 0.0;
  num dep = 0;

  Future checking()async{
    var _cat = await autreOperations.getCatById(widget.currentBudget.cat_id!, widget.currentUser);

    setState(() {
      cat = _cat;
    });

    var _trans_dep = (await autreOperations.getSommeBudget(widget.currentUser, cat!.id!,widget.currentBudget.date_debut!,widget.currentBudget.date_fin!))[0]['TOTAL'];

    setState(() {
      if(_trans_dep!=null) {
        dep = _trans_dep;
        widget.currentBudget.restant = widget.currentBudget.montant! - dep;

      } else {
        dep = 0;
        widget.currentBudget.restant = widget.currentBudget.montant!;

      }
    });
  }

  @override
  void initState() {
    _percent = 0.0;
    checking().whenComplete(() {
      setState(() {
        _percent = ((widget.currentBudget.restant! * 100) / widget.currentBudget.montant!).floorToDouble();
        _percent < 0.0 ? _percent = 0.0 : _percent = _percent;
      });

      autreOperations.updateBudget(widget.currentBudget);
    });
    // TODO: implement initState
    super.initState();
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
                              child: CircularPercentIndicator(
                                radius: 150.0,
                                lineWidth: 10.0,
                                animation: true,
                                percent: _percent / 100,
                                center: Text(
                                  "    ${_percent.toInt()}%\n restant",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.black,fontStyle: FontStyle.italic),
                                ),
                                footer: Text(
                                  "${widget.currentBudget.titre}",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Color(cat!.color!),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: Text("${widget.currentBudget.description}",style:
                              TextStyle(fontStyle: FontStyle.italic),),
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
                          Text("Catégorie"),
                          Text("${cat!.nom}",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dépenses"),
                          Text("${dep} FCFA",style: TextStyle(color: Colors.red),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Restant"),
                          Text("${widget.currentBudget.restant} FCFA",style: TextStyle(color: Colors.green),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Début"),
                          Text("${widget.currentBudget.date_debut!.day}/${widget.currentBudget.date_debut!.month}/${widget.currentBudget.date_debut!.year} ",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fin"),
                          Text("${widget.currentBudget.date_fin!.day}/${widget.currentBudget.date_fin!.month}/${widget.currentBudget.date_fin!.year} ",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    )
                  ],
                )
                ,
              ),
              Container(
                child: FutureBuilder<List<TransactionModel>?>(
                    future: transactionOperations.getTransactionsByCatForBudget(widget.currentUser,cat!,widget.currentBudget.date_debut!,widget.currentBudget.date_fin!),
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
                              color: trans.type == "Revenu" ? Colors.green[50] : Colors.red[50],
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
                                        Text(
                                          trans.type == "Revenu" ? '+${trans.montant}' : '-${trans.montant}',style: TextStyle(color: trans.type == "Revenu" ? Colors.green[900] : Colors.red[900]),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text('${trans.datetime!.hour}:${trans.datetime!.minute}'),
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
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ModifierBudget(budget: widget.currentBudget,user: widget.currentUser,)));
    }else if(choice == PopMenu.Supprimer){
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Supprimer ce budget?'),
            content: const Text('Etes-vous vraiment sûre?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Non'),
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: ()async {
                  await autreOperations.deleteBudget(widget.currentBudget.id);
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


