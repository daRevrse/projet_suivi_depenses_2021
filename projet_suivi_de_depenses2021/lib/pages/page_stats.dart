import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageStats extends StatefulWidget {
  final String userName;
  const PageStats({Key? key,required this.userName}) : super(key: key);
  @override
  _PageStatsState createState() => _PageStatsState();
}

class _PageStatsState extends State<PageStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
            title: FittedBox(child: Text('${widget.userName}'),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal,
            //actions: [IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal[800],
                child: Text("Statistiques",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            )
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart,size: 140,color: Colors.grey,),
              Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
            ],
          ),

        ),
      ),
    );
  }
}
