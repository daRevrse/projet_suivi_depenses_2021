import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';

class PageAfficherTransaction extends StatefulWidget {
  final TransactionModel transaction;
  const PageAfficherTransaction({Key? key,required this.transaction}) : super(key: key);

  @override
  _PageAfficherTransactionState createState() => _PageAfficherTransactionState();
}

class _PageAfficherTransactionState extends State<PageAfficherTransaction> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(Icons.mode),
              onPressed: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewTransaction()));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){

              },
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        height: 300,
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
                Text("Montant :"),
                Text(widget.transaction.montant.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date :"),
                Text(widget.transaction.datetime.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Type :"),
                Text(widget.transaction.type.toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
