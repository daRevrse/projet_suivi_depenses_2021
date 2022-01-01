import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Constants/popMenuConsts.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/remboursementModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_remboursement.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_updates/dette_update.dart';
import '../../root_app_page.dart';

class PageDette extends StatefulWidget {
  final DetteModel currentDette;
  final User currentUser;
  const PageDette({Key? key,required this.currentDette,required this.currentUser}) : super(key: key);

  @override
  _PageDetteState createState() => _PageDetteState();
}

class _PageDetteState extends State<PageDette> {

  TransactionOperations transactionOperations = TransactionOperations();
  AutreOperations autreOperations = AutreOperations();

  num restant = 0;

  void calcRest() async {
    var total_remb = (await transactionOperations.getRestant(widget.currentUser,widget.currentDette))[0]['TOTAL'];

    //print(total_sum);
    setState(() {
      if(total_remb!=null) {
        restant = widget.currentDette.montant!;
      } else {
        restant = widget.currentDette.montant! - total_remb;

      }
    });

    DetteModel _dette = DetteModel(widget.currentDette.creancier, widget.currentDette.description, widget.currentDette.montant, restant, widget.currentDette.datetime, widget.currentDette.user_id);

    await autreOperations.updateDette(_dette);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calcRest();
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
                  return PopMenuRemboursement.choices.map((String choice){
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
                                backgroundColor: Colors.black,
                                child: Text(widget.currentDette.creancier![0],
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: Text('${widget.currentDette.creancier}'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: Text("${widget.currentDette.description}"),
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
                          Text("Départ"),
                          Text("${widget.currentDette.montant} FCFA",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Restant"),
                          Text("${widget.currentDette.restant} FCFA",style: TextStyle(color: Colors.red),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date"),
                          Text("${widget.currentDette.datetime!.day}/${widget.currentDette.datetime!.month}/${widget.currentDette.datetime!.year} ",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    )
                  ],
                )
                ,
              ),
              Container(
                child: FutureBuilder<List<RemboursementModel>?>(
                    future: transactionOperations.getRemboursementsByDette(widget.currentUser,widget.currentDette),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<RemboursementModel>?> snapshot) {
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
                          children: snapshot.data!.map((remb) {
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
                                    title: Text('Remboursement'),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('${remb.montant}'),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text('${remb.datetime!.day}-${remb.datetime!.month}-${remb.datetime!.year} ${remb.datetime!.hour}:${remb.datetime!.minute}'),
                                        )
                                      ],
                                    ),
                                    onTap: (){
                                      //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageAfficherTransaction(transaction: trans,)));
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
    if(choice == PopMenuRemboursement.Rembourser){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewRemboursement(dette: widget.currentDette,user: widget.currentUser,)));
    }
    else if(choice == PopMenuRemboursement.Modifier){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ModifierDette(dette: widget.currentDette,user: widget.currentUser,)));
    }
    else if(choice == PopMenuRemboursement.Supprimer){
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Supprimer cette dette?'),
            content: const Text('Etes-vous vraiment sûre?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Non'),
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: ()async {
                  await autreOperations.deleteDette(widget.currentDette.id);
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


