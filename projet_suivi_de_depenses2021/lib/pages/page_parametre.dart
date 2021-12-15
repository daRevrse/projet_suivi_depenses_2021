import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouveau_budget.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_categorie.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_updates/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page_connexion.dart';

class PageParametre extends StatefulWidget {
  final String userName;
  const PageParametre({Key? key,required this.userName}) : super(key: key);
  @override
  _PageParametreState createState() => _PageParametreState();
}

class _PageParametreState extends State<PageParametre> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                child: Text("Paramètres",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children:[
              Material(
                elevation: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: AlignmentDirectional.centerStart,
                  color: Colors.white,
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children:[
                      TextButton(
                        style: ButtonStyle(
                        ),
                        onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Profil()));
                        } ,
                        child: Container(
                          width: double.infinity,
                          child: Text('Profil',
                              style:TextStyle(
                                color: Colors.black,
                              )

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                        ),
                        onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NewBudget()));
                        } ,
                        child: Container(
                          width: double.infinity,
                          child: Text('Budget',
                              style:TextStyle(
                                color: Colors.black,
                              )

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                        ),
                        onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> categorie()));
                        } ,
                        child: Container(
                          width: double.infinity,
                          child: Text('Catégories',
                              style:TextStyle(
                                color: Colors.black,
                              )

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                        ),
                        onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Profil()));
                        } ,
                        child: Container(
                          width: double.infinity,
                          child: Text('Donnez nous une note',
                              style:TextStyle(
                                color: Colors.black,
                              )

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed:() {
                          setState(() async {
                            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.remove("userName");
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (_) => PageConnexion()));
                          });
                        } ,
                        child: Container(
                          width: double.infinity,
                          child: Text('Deconnexion',
                              style:TextStyle(
                                color: Colors.black,
                              )

                          ),
                        ),
                      ),

                    ],
                  ),

                ),
              )

            ]
        ),
      ),
    );
  }
}
