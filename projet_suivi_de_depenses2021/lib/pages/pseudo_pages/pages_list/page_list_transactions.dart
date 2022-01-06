import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

DateTime date = DateTime.now();
DateTime predate = DateTime.now();
DateTime nextdate = DateTime.now();
class ListeTransactions extends StatefulWidget {
  final User user;
  String periode;
  ListeTransactions({Key? key,required this.user,required this.periode}) : super(key: key);

  @override
  _ListeTransactionsState createState() => _ListeTransactionsState();
}

class _ListeTransactionsState extends State<ListeTransactions> {

  TransactionOperations transactionOperations = TransactionOperations();
  late bool isDay = false;
  late bool isWeek = false;
  late bool isMois = false;
  late bool isYear = false;
  late bool isAll = true;

  var listTrans;

  @override
  void initState() {
    setState(() {
      date = DateTime.now();
      predate = DateTime.now();
      nextdate = DateTime.now();
    });
    // TODO: implement initState
    super.initState();
  }

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
        title: Text("Transactions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransaction(user: widget.user,)));
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
                                  child: Text("Sélectionnez l'intervalle de temps",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),

                                  height: 50,
                                  alignment: Alignment.center,
                                ),
                                Divider(height: 0),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isDay = value!;
                                      isWeek = false;
                                      isMois = false;
                                      isYear = false;
                                      isAll = false;

                                      widget.periode = "Day";
                                    });
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(builder: (_) => ListeTransactions(user: widget.user,periode: widget.periode,)));
                                  },
                                  value: isDay,
                                  title: Text("Jour"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isWeek = value!;
                                      isDay = false;
                                      isMois = false;
                                      isYear = false;
                                      isAll = false;
                                      widget.periode = "Week";
                                    });
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(builder: (_) => ListeTransactions(user: widget.user,periode: widget.periode,)));
                                  },
                                  value: isWeek,
                                  title: Text("Semaine"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isMois = value!;
                                      isDay = false;
                                      isWeek = false;
                                      isYear = false;
                                      isAll = false;
                                      widget.periode = "Mois";
                                    });
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(builder: (_) => ListeTransactions(user: widget.user,periode: widget.periode,)));
                                  },
                                  value: isMois,
                                  title: Text("Mois"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isYear = value!;
                                      isDay = false;
                                      isWeek = false;
                                      isMois = false;
                                      isAll = false;
                                      widget.periode = "Year";
                                    });
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(builder: (_) => ListeTransactions(user: widget.user,periode: widget.periode,)));
                                  },
                                  value: isYear,
                                  title: Text("Année"),
                                  activeColor: Colors.deepOrange,
                                  secondary: Icon(Icons.filter_1),
                                ),
                                Divider(height: 5),
                                CheckboxListTile(
                                  onChanged: (value){
                                    setstate(() {
                                      isAll = value!;
                                      isDay = false;
                                      isWeek = false;
                                      isMois = false;
                                      isYear = false;
                                      widget.periode = "Tous";
                                    });
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(builder: (_) => ListeTransactions(user: widget.user,periode: widget.periode,)));
                                  },
                                  value: isAll,
                                  title: Text("Tous"),
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
              child: Periode(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<TransactionModel>?>(
              future: widget.periode == "Tous" ? transactionOperations.getTransactionsByUser(widget.user) : listTrans,
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PageAfficherTransaction(transaction: trans,currentUser: widget.user,)));
                                },
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

  Widget Periode(){
    setState(() {

    });
    if(widget.periode == "Day") {
      setState(() {
        //listTrans = transactionOperations.getTransactionsByDate(widget.user, date);
        isDay = true;
        isWeek = false;
        isMois = false;
        isYear = false;
        isAll = false;
      });
      return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 IconButton(onPressed: (){setState((){
                   if (date == DateTime.now()) {
                     date = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
                     predate = date.subtract(Duration(days: 1));
                   }else{
                     date = date.subtract(Duration(days: 1));
                     predate = date.subtract(Duration(days: 1));
                   }
                   listTrans = transactionOperations.getTransactionsByPeriode(widget.user, predate,date);
                 });}, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),

                 Text(DateFormat.yMMMMd("fr_FR").format(date).toString(),style: TextStyle(color: Colors.white),),

                 IconButton(onPressed: (){setState(() {
                   if (date == DateTime.now()) {
                     date = date.add(Duration(hours: 24 - date.hour, minutes: 1440 - date.minute, seconds: 86400 - date.second));
                     nextdate = date.add(Duration(days: 1));
                   }else{
                     date = date.add(Duration(days: 1));
                     nextdate = date.add(Duration(days: 1));
                   }
                   listTrans = transactionOperations.getTransactionsByPeriode(widget.user, date,nextdate);
                 });}, icon: Icon(Icons.arrow_forward_ios),color: Colors.white,),
              ],
            );
    }
    if(widget.periode == "Week") {
      setState(() {
        isDay = false;
        isWeek = true;
        isMois = false;
        isYear = false;
        isAll = false;
      });
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){setState(() {
            predate = predate.subtract(Duration(days: 7));
            nextdate = predate.add(Duration(days: 7));
            listTrans = transactionOperations.getTransactionsByPeriode(widget.user, predate, nextdate);
          });}, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),

          Text("${DateFormat.yMMMMd("fr_FR").format(predate)} - ${DateFormat.yMMMMd("fr_FR").format(nextdate)}",style: TextStyle(color: Colors.white),),

          IconButton(onPressed: (){setState(() {
            nextdate = nextdate.add(Duration(days: 7));
            predate = nextdate.subtract(Duration(days: 7));
            listTrans = transactionOperations.getTransactionsByPeriode(widget.user, predate, nextdate);
          });}, icon: Icon(Icons.arrow_forward_ios),color: Colors.white,),
        ],
      );
    }
    if(widget.periode == "Mois") {
      setState(() {
        isDay = false;
        isWeek = false;
        isMois = true;
        isYear = false;
        isAll = false;
      });
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){
            setState(() {
            if (date.month == 4 || date.month == 6 || date.month == 9 || date.month == 11) {
              date = date.subtract(Duration(days: 30));
              predate = date.subtract(Duration(days: 30));
              //nextdate = predate.add(Duration(days: 30));
            }else if((date.year%400 == 0 || date.year%100 != 0) && date.year%4 == 0 && date.month == 2){
              date = date.subtract(Duration(days: 29));
              predate = date.subtract(Duration(days: 29));
              //nextdate = predate.add(Duration(days: 29));
            }else if(date.month == 2){
              date = date.subtract(Duration(days: 28));
              predate = date.subtract(Duration(days: 28));
              //nextdate = predate.add(Duration(days: 28));
            }else{
              date = date.subtract(Duration(days: 31));
              predate = date.subtract(Duration(days: 31));
              //nextdate = predate.add(Duration(days: 31));
            }
            listTrans = transactionOperations.getTransactionsByPeriode(widget.user, predate, date);
          }
          );}, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),

          Text(DateFormat.yMMMM("fr_FR").format(date),style: TextStyle(color: Colors.white),),

          IconButton(onPressed: (){setState(() {
            if (date.month == 4 || date.month == 6 || date.month == 9 || date.month == 11) {
              date = date.add(Duration(days: 30));
              nextdate = date.add(Duration(days: 30));
            }else if((date.year%400 == 0 || date.year%100 != 0) && date.year%4 == 0 && date.month == 2){
              date = date.add(Duration(days: 29));
              nextdate = date.add(Duration(days: 29));
            }else if(date.month == 2){
              date = date.add(Duration(days: 28));
              nextdate = date.add(Duration(days: 28));
            }else{
              date = date.add(Duration(days: 31));
              nextdate = date.add(Duration(days: 31));
            }
            listTrans = transactionOperations.getTransactionsByPeriode(widget.user, date, nextdate);
          });}, icon: Icon(Icons.arrow_forward_ios),color: Colors.white,),
        ],
      );
    }
    if(widget.periode == "Year") {
      setState(() {
        isDay = false;
        isWeek = false;
        isMois = false;
        isYear = true;
        isAll = false;
      });
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){setState(() {
            if((date.year%400 == 0 || date.year%100 != 0) && date.year%4 == 0){
              date = date.subtract(Duration(days: 366));
              predate = date.subtract(Duration(days: 366));
            }else{
              date = date.subtract(Duration(days: 365));
              predate = date.subtract(Duration(days: 365));
            }
            listTrans = transactionOperations.getTransactionsByPeriode(widget.user, predate, date);
          });}, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),

          Text(date.year.toString(),style: TextStyle(color: Colors.white),),

          IconButton(onPressed: (){setState(() {
            if ((date.year%400 == 0 || date.year%100 != 0) && date.year%4 == 0) {
              date = date.add(Duration(days: 366));
              nextdate = date.add(Duration(days: 366));
            }else{
              date = date.add(Duration(days: 365));
              nextdate = date.add(Duration(days: 365));
            }
            listTrans = transactionOperations.getTransactionsByPeriode(widget.user, date, nextdate);
          });}, icon: Icon(Icons.arrow_forward_ios),color: Colors.white,),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        /*IconButton(onPressed: (){setState(() {
          date = date.subtract(Duration(days: 365));
        });}, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),*/

        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text("Toutes les transactions",style: TextStyle(color: Colors.white),),
        ),

        /*IconButton(onPressed: (){setState(() {
          date = date.add(Duration(days: 365));
        });}, icon: Icon(Icons.arrow_forward_ios),color: Colors.white,),*/
      ],
    );
    }

}
