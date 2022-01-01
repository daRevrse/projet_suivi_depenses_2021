import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/main.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_dette.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_dette.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

class ListeDettes extends StatefulWidget {
  final User user;
  const ListeDettes({Key? key,required this.user}) : super(key: key);

  @override
  _ListeDettesState createState() => _ListeDettesState();
}

class _ListeDettesState extends State<ListeDettes> {

  AutreOperations autreOperations = AutreOperations();
  late bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> RootPage(user: widget.user,)));
        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        elevation: 3,
        backgroundColor: Colors.teal,
        title: Text("Dettes"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewDette(user: widget.user,)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<DetteModel>?>(
              future: autreOperations.getDettesByUser(widget.user),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DetteModel>?> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                        Text("Aucune dette",style: TextStyle(fontSize: 20,color: Colors.grey),)
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
                        Text("Aucune dette",style: TextStyle(fontSize: 20,color: Colors.grey),)
                      ],
                    ),

                  ))
                      : Container(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.map((dette) {
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
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageDette(currentDette: dette,currentUser: widget.user,)));
                                },
                                leading: CircleAvatar(child: Text("${dette.creancier![0]}"),),
                                title: Text("${dette.creancier}"),
                                subtitle: Text("${dette.description}"),
                                trailing: Text("${dette.montant}"),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

}
