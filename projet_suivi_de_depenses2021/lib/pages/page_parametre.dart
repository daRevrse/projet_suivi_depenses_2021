import 'package:flutter/material.dart';

class Parametre extends StatefulWidget {
  const Parametre({Key? key}) : super(key: key);

  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                child: Text("Paramètres",style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            )
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text("Nom de l'utilisateur"),
            trailing: Icon(Icons.mode_sharp),
          ),
        ),
      ),
    );
  }
}
