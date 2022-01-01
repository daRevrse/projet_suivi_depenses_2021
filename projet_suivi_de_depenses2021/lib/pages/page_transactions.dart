import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction_via_acceuil.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_list/page_list_transactions.dart';
import 'package:collection/collection.dart';


class PageTransaction extends StatefulWidget {
  final User currentUser;
  const PageTransaction({Key? key,required this.currentUser}) : super(key: key);


  @override
  _PageTransactionState createState() => _PageTransactionState();
}

class _PageTransactionState extends State<PageTransaction> {

  //UserOperations userOperations = UserOperations();
  TransactionOperations transactionOperations = TransactionOperations();
  CompteOperations compteOperations = CompteOperations();

  var date = DateTime.now();

  num somme = 0;

  void calcTotal() async {
    var total_sum = (await compteOperations.getSomme(widget.currentUser))[0]['TOTAL'];

    //print(total_sum);
    setState(() {
      if(total_sum!=null)
      somme = total_sum;
      else somme = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calcTotal();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    initializeDateFormatting("fr");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
            automaticallyImplyLeading: false,
            title: FittedBox(child: Text('${widget.currentUser.nom}'),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 10,top: 5),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ListeTransactions(user: widget.currentUser,periode: "Tous",)));
                  }, icon: Icon(Icons.article_outlined ,size: 30,))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal[800],
                child: Text("Transactions",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            )
        )
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: ClippingClass(),
              child: Container(
                height: 150,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/575270.png",height: 80,width: 80,),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Solde totale en Cfa",style: TextStyle(fontSize: 20),),
                              Container(
                                  child: AutoSizeText(
                                    '${somme}',
                                    //style: TextStyle(color: Colors.black,fontSize: 40),
                                    presetFontSizes: [50,25,20],
                                    maxLines: 2,
                                    overflowReplacement: Text("Vous etes trop riche"),
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                  height: 50,
                  width: screenSize.width,
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Container(
                            child: Text(
                              DateFormat.yMMMMd("fr_FR").format(date),
                              style: TextStyle(fontSize: 30),
                            )
                        ),
                      ),
                      Container(
                          child: IconButton(onPressed: (){
                            setState(() {
                            });
                          }, icon: Icon(Icons.view_list),alignment: Alignment.center,))
                    ],
                  )
              ),
            ),

            Container(
              child: FutureBuilder<List<TransactionModel>?>(
                  future: transactionOperations.getTransactionsByDate(widget.currentUser,date),
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
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageAfficherTransaction(transaction: trans,)));
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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransactionViaAcceuil(user: widget.currentUser,)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );

  }
}


class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height-40);
    path.quadraticBezierTo(size.width / 4, size.height,
        size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

