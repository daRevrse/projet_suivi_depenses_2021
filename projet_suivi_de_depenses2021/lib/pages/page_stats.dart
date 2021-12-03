import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(title: FittedBox(child: Text("Kodjo"),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal,
            //actions: [IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal,
                child: Text("Statistiques",style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            )
        ),
      ),
      body: Container(
        color: Colors.grey[300],
      ),
    );
  }
}
