import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {


  var date = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(title: FittedBox(child: Text("Nom de l'utilisateur"),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30),
            backgroundColor: Colors.teal,
            //actions: [IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal,
                child: Text("Transactions",style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            )
      ),
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
           ClipPath(
            clipper: ClippingClass(),
            child: Container(
              height: 170,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: ListTile(
                    leading: Icon(Icons.home,size: 60,),
                    title: Text("Solde",style: TextStyle(fontSize: 20),),
                    subtitle: FittedBox(child: Text("Cfa 20,00000000000000",style: TextStyle(fontSize: 50),)),
                  ),
              ),
            ),
          ),

           Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
                    height: 70,
                    width: screenSize.width,
                    alignment: Alignment.center,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Container(child: Text(DateFormat('dd-MM-yyyy').format(date),style: TextStyle(fontSize: 40,),)),
                        ),
                        Container(child: IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today),alignment: Alignment.center,))
                      ],
                    )
                ),
          ),

          Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Le titre"),
                  subtitle: Text("La description"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Montant"),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("Heure"),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent[700],
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
