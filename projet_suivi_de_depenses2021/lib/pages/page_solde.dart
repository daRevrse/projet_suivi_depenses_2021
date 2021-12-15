import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

class PageSolde extends StatefulWidget {
  final String userName;
  const PageSolde({Key? key,required this.userName}) : super(key: key);

  @override  
  _PageSolde createState() => _PageSolde();
}

class _PageSolde extends State<PageSolde> {

  CompteOperations compteOperations = CompteOperations();
  TextEditingController controller = TextEditingController();

    @override
    Widget build(BuildContext context) {
      final screenSize = MediaQuery
          .of(context)
          .size;

      return Scaffold(
        //backgroundColor: Colors.teal,
          body: SingleChildScrollView(
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
                    color: Colors.teal,
                    child: Column(
                      //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        //Icon(Icons.alarm,size: 80,color: Colors.black,),
                        Image.asset(
                          'assets/575271.png', width: 100, height: 100,),
                        Text('Solde de départ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text('Ajouter un solde pour votre compte'),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 50, left: 100, right: 100),
                          child: TextField(
                            controller: controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '0 FCFA',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              onPressed: () async {

                                CompteModel compte = CompteModel("Espèce"," ",int.parse(controller.text));
                                CompteModel com_pte = CompteModel("Banque"," ",0);
                                CompteModel com__pte = CompteModel("Epargne"," ",0);
                                await compteOperations.saveCompte(compte);
                                await compteOperations.saveCompte(com_pte);
                                await compteOperations.saveCompte(com__pte);



                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (_) => RootPage()));
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
          )
      );
    }
  }

