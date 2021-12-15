import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';
import 'package:projet_suivi_de_depenses2021/pages/page_solde.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet_suivi_de_depenses2021/Database/user_operations.dart';


class PageConnexion extends StatefulWidget {
  const PageConnexion({Key? key}) : super(key: key);

  @override
  _PageConnexion createState() => _PageConnexion();
}

class _PageConnexion extends State<PageConnexion> {

  UserOperations userOperations = UserOperations();
  TextEditingController controller = TextEditingController();
  
 /* void _goToRoot(context,String userName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RootPage(value: userName,)));
  }*/

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: Colors.teal,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              color: Colors.teal,
              width: screenSize.width,
              height: screenSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Icon(Icons.account_circle,size: 80,color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 6),
                          child: Text('Ajouter un compte',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('Entrez un nom pour votre compte'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:50,left: 100,right: 100),
                          child: TextField(
                            controller: controller,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,color: Colors.deepOrange,),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.deepOrange)
                              ),
                              hintText: 'Votre nom',
                              helperText: "Ex: Kodjo, Afi, Ashley...",
                            ),
                            keyboardType: TextInputType.name,
                            onSubmitted: (val) => controller.text = val,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 50),
                            child:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white
                              ),
                              onPressed: () async {
                                /*List<User> users = await DatabaseHelper.instance.getUsers();
                                String userName = users.first.nom;
                                _goToRoot(context, userName);*/

                              if (controller.text != " ") {

                                final user = User(
                                    nom: controller.text);
                                userOperations.add(user);

                                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.setString("userName", user.nom);

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (_) => PageSolde(userName: user.nom)));
                              }

                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Suivant",style: TextStyle(color: Colors.black),),
                                  Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Image.asset("assets/apk.jpg"),
                    ),
                  )
                ],
              ),
            ),
          ),
        )

    );

  }

}
