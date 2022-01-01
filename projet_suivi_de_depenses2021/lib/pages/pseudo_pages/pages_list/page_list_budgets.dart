import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/budgetModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/main.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_dette.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

class ListeBudgets extends StatefulWidget {
  final User user;
  const ListeBudgets({Key? key,required this.user}) : super(key: key);

  @override
  _ListeBudgetsState createState() => _ListeBudgetsState();
}

class _ListeBudgetsState extends State<ListeBudgets> {

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
        title: Text("Budgets"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewBudget(user: widget.user,)));
            },
          ),
          /*IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return StatefulBuilder(
                        builder: (context, setstate) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)
                                )
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.teal,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                                  ),
                                  child: Text("Sélectionnez l'intervalle de temps",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                  height: 50,
                                  alignment: Alignment.center,
                                ),
                                Divider(height: 0),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isSelected = value!;
                                    });
                                  },
                                  value: isSelected,
                                  title: Text("Jour"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isSelected = value!;
                                    });
                                  },
                                  value: isSelected,
                                  title: Text("Semaine"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isSelected = value!;
                                    });
                                  },
                                  value: isSelected,
                                  title: Text("Mois"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isSelected = value!;
                                    });
                                  },
                                  value: isSelected,
                                  title: Text("Année"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isSelected = value!;
                                    });
                                  },
                                  value: isSelected,
                                  title: Text("Tous"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isSelected = value!;
                                    });
                                  },
                                  value: isSelected,
                                  title: Text("Personnalisé"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  });
            },
          )*/
        ],
        /*bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            //color: Colors.teal[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),

                Text(DateTime.now().toString(),style: TextStyle(color: Colors.white),),

                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios),color: Colors.white,),
              ],
            ),
          ),
        ),*/
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<BudgetModel>?>(
              future: autreOperations.getBudgetsByUser(widget.user),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BudgetModel>?> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                        Text("Aucun budget",style: TextStyle(fontSize: 20,color: Colors.grey),)
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
                        Text("Aucun budget",style: TextStyle(fontSize: 20,color: Colors.grey),)
                      ],
                    ),

                  ))
                      : Container(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.map((budget) {
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageBudget(currentBudget: budget,currentUser: widget.user,)));
                                },
                                leading: CircleAvatar(child: Text("${budget.titre![0]}"),),
                                title: Text("${budget.titre}"),
                                subtitle: Text("${budget.description}"),
                                trailing: Text("${budget.montant}"),
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

      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransaction()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),*/
    );
  }

}
