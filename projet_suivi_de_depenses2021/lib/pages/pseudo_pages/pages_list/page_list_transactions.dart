import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

class ListeTransactions extends StatefulWidget {
  const ListeTransactions({Key? key}) : super(key: key);

  @override
  _ListeTransactionsState createState() => _ListeTransactionsState();
}

class _ListeTransactionsState extends State<ListeTransactions> {

  TransactionOperations transactionOperations = TransactionOperations();
  late bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> RootPage()));
        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        elevation: 3,
        backgroundColor: Colors.teal,
        title: Text("Transactions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransaction()));
            },
          ),
          IconButton(
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
          )
        ],
        bottom: PreferredSize(
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
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<TransactionModel>?>(
              future: transactionOperations.getTransactionModelData(),
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
                      : Container(
                        child: ListView(
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
                                title: Text('${trans.titre}'),
                                subtitle: Text('${trans.description}'),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${trans.montant}'),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text('${trans.type}'),
                                    )
                                  ],
                                ),
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
