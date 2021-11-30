import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/pages/connexion.dart';
import 'package:projet_suivi_de_depenses2021/pages/page_parametre.dart';
import 'package:projet_suivi_de_depenses2021/pages/page_portefeuille.dart';
import 'package:projet_suivi_de_depenses2021/pages/page_stats.dart';
import 'package:projet_suivi_de_depenses2021/pages/page_transactions.dart';
import 'package:projet_suivi_de_depenses2021/pages/solde.dart';

void main() {
  runApp(const MainPage());
}
class page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.grey,
            ),
   );
     }

}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int pageIndex = 0;
  final screens = [
    connexion(),
    solde(),
    Transaction(),
    Portefeuille(),
    Stats(),
    Parametre()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: connexion()/*Scaffold(
        appBar: AppBar(title: Text("Home"),
        backgroundColor: Colors.teal,
        ),
        body: IndexedStack(
          index: pageIndex,
          children: screens,

        ),

        //La bar de naviguation du bas
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index) => setState(() =>pageIndex = index),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.white,),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Portefeuille",backgroundColor: Colors.white,),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Stats",backgroundColor: Colors.white,),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Parametre",backgroundColor: Colors.white,),
        ],),
      )*/,
    );
  }
}


