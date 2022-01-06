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
  bool check = false;



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
                              errorText: check ? "Veuillez entrez un nom" : null,
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
                                var _id = await userOperations.getCount();

                              if (controller.text.isNotEmpty) {

                                final User user = User(controller.text);

                                setState(() {
                                  user.id = _id;
                                });

                                userOperations.add(user);

                                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.setString("userName", user.nom!);
                                sharedPreferences.setInt("userId", user.id!);

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (_) => PageSolde(user: user)));
                              }else {
                                setState(() {
                                check = true;
                              });
                              };

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
                      child: Image.asset("assets/paygate.jpg"),
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
