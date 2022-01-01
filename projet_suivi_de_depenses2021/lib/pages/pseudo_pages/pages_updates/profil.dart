import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

var username;
class Profil extends StatefulWidget {
  final User user;
  const Profil({Key? key,required this.user}) : super(key: key);

  @override
  _Profil createState() => _Profil();
}

class _Profil extends State<Profil> {

  TextEditingController controller = new TextEditingController();
  CompteOperations compteOperations = CompteOperations();

  get pageIndex => null;

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userName = sharedPreferences.getString("userName");
    setState(() {
      username = userName;
    });
  }

  num somme = 0;

  void calcTotal() async {
    var total_sum = (await compteOperations.getSomme(widget.user))[0]['TOTAL'];

    print(total_sum);
    setState(() {
      somme = total_sum;
    });
  }

  @override
  void initState() {

    getValidationData();
    // TODO: implement initState
    super.initState();
    calcTotal();
  }

  @override
  Widget build(BuildContext context) {
    var user_name = username;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Profile"),
        backgroundColor: Colors.teal,
        actions: [
          /*RaisedButton(
            elevation: 10,
            color: Colors.white,
            onPressed: (){},
            child: Text("Enregistrer"
            ),
          )*/

        ],
      ),
      body:Container(
        color: Colors.white,
        //height: 400,

        child:Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[

            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25,left: 15),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(user_name[0],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25,left: 15),
                  child: Column(children: [Text('${user_name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left: 15),
                      child: Row(children:[Text('Balance : ${somme}'),]),
                    ),
                  ],),
                )
              ],
            ),


            Padding(
              padding: const EdgeInsets.only(top: 30,left: 5),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [Text('Email'),],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text('example@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8),
              child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text('Date de naissance'),],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text('08/12/1999',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),],),
            ),

            Container(child:Row(mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Text('Password'),
              ],
            )
            ),

          ],

        ),
      ),

    );


  }
}
