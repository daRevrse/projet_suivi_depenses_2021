import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_connexion.dart';
import 'page_parametre.dart';
import 'page_portefeuille.dart';
import 'page_stats.dart';
import 'page_transactions.dart';

var userid;

class RootPage extends StatefulWidget {
  final User user;
  const RootPage({Key? key,required this.user}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  void initState() {
    // TODO: implement initState
    getValidationData().whenComplete(() async{
        if(userid == null){
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => PageConnexion()));
        }
    });
    super.initState();
  }

  int pageIndex = 0;

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getInt("userId");
    setState(() {
      userid = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    User current = widget.user;
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: [
        PageTransaction(currentUser: current),
        PagePortefeuille(currentUser: current),
        PageStats(currentUser: current),
        PageParametre(currentUser: current)
        ],
      ),

      //La bar de naviguation du bas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) => setState(() =>pageIndex = index),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.teal,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz,size: 30,),label: "Transactions",backgroundColor: Colors.white,),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet),label: "Portefeuille",backgroundColor: Colors.white,),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: "Stats",backgroundColor: Colors.white,),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Parametre",backgroundColor: Colors.white,),
        ],),
    );
  }
}
