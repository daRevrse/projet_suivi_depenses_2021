import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

class PageSolde extends StatefulWidget {
  final User user;
  const PageSolde({Key? key,required this.user}) : super(key: key);

  @override  
  _PageSolde createState() => _PageSolde();
}

class _PageSolde extends State<PageSolde> {

  CompteOperations compteOperations = CompteOperations();
  AutreOperations autreOperations = AutreOperations();
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
                        Text('Solde de d??part',
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
                              onPressed: (){

                                loadPortefeuille();
                                loadCategories();

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (_) => RootPage(user: widget.user,)));
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
          )
      );
    }

  loadPortefeuille(){
      if(controller.text.isEmpty){
        CompteModel compte = CompteModel("Esp??ce"," ",0,Colors.green.value,widget.user.id);
        CompteModel com_pte = CompteModel("Banque"," ",0,Colors.blue.value,widget.user.id);
        CompteModel com__pte = CompteModel("Epargne"," ",0,Colors.red.value,widget.user.id);
        compteOperations.saveCompte(compte);
        compteOperations.saveCompte(com_pte);
        compteOperations.saveCompte(com__pte);
      }else{
        CompteModel compte = CompteModel("Esp??ce"," ",int.parse(controller.text),Colors.green.value,widget.user.id);
        CompteModel com_pte = CompteModel("Banque"," ",0,Colors.blue.value,widget.user.id);
        CompteModel com__pte = CompteModel("Epargne"," ",0,Colors.red.value,widget.user.id);
        compteOperations.saveCompte(compte);
        compteOperations.saveCompte(com_pte);
        compteOperations.saveCompte(com__pte);
      }
  }

    loadCategories(){

      CategorieModel cat_al = CategorieModel("Alimentation", "D??pense", Colors.green.value, widget.user.id);
      CategorieModel cat_uti = CategorieModel("Utilitaire", "D??pense", Colors.blueGrey.value, widget.user.id);
      CategorieModel cat_vet = CategorieModel("V??tement", "D??pense", Colors.deepPurpleAccent.value, widget.user.id);
      CategorieModel cat_edu = CategorieModel("Education", "D??pense", Colors.limeAccent.value, widget.user.id);
      CategorieModel cat_div = CategorieModel("Divertissement", "D??pense", Colors.pink.value, widget.user.id);
      CategorieModel cat_spo = CategorieModel("Sport", "D??pense", Colors.orange.value, widget.user.id);
      CategorieModel cat_cad = CategorieModel("Cadeau", "D??pense", Colors.indigo.value, widget.user.id);
      CategorieModel cat_san = CategorieModel("Sant??", "D??pense", Colors.red.value, widget.user.id);
      CategorieModel cat_tra = CategorieModel("Transport", "D??pense", Colors.tealAccent.value, widget.user.id);
      CategorieModel cat_voy = CategorieModel("Voyage", "D??pense", Colors.brown.value, widget.user.id);
      CategorieModel cat_ach = CategorieModel("Achat", "D??pense", Colors.yellow.value, widget.user.id);
      CategorieModel cat_ent = CategorieModel("Entretien", "D??pense", Colors.deepPurple.value, widget.user.id);
      CategorieModel cat_per = CategorieModel("Perte", "D??pense", Colors.cyanAccent.value, widget.user.id);
      CategorieModel cat_au = CategorieModel("Autre", "D??pense", Colors.grey.value, widget.user.id);
      CategorieModel cat_rem = CategorieModel("Remboursement", "D??pense", Colors.redAccent.value, widget.user.id);


      CategorieModel cat_sal = CategorieModel("Salaire", "Revenu", Colors.blueAccent.value, widget.user.id);
      CategorieModel cat_cou = CategorieModel("Coupon", "Revenu", Colors.deepOrangeAccent.value, widget.user.id);
      CategorieModel cat_pri = CategorieModel("Prix", "Revenu", Colors.indigoAccent.value, widget.user.id);
      CategorieModel cat_prim = CategorieModel("Prime", "Revenu", Colors.greenAccent.value, widget.user.id);
      CategorieModel cat_divi = CategorieModel("Dividende", "Revenu", Colors.limeAccent.value, widget.user.id);
      CategorieModel cat_Inv = CategorieModel("Investissement", "Revenu", Colors.amberAccent.value, widget.user.id);
      CategorieModel cat_lot = CategorieModel("Lotterie", "Revenu", Colors.cyanAccent.value, widget.user.id);
      CategorieModel cat_remb = CategorieModel("Remboursement", "Revenu", Colors.redAccent.value, widget.user.id);
      CategorieModel cat_aut = CategorieModel("Autre", "Revenu", Colors.grey.value, widget.user.id);


      autreOperations.saveCat(cat_al);
      autreOperations.saveCat(cat_aut);
      autreOperations.saveCat(cat_au);
      autreOperations.saveCat(cat_lot);
      autreOperations.saveCat(cat_rem);
      autreOperations.saveCat(cat_remb);
      autreOperations.saveCat(cat_divi);
      autreOperations.saveCat(cat_Inv);
      autreOperations.saveCat(cat_cou);
      autreOperations.saveCat(cat_pri);
      autreOperations.saveCat(cat_prim);
      autreOperations.saveCat(cat_ent);
      autreOperations.saveCat(cat_per);
      autreOperations.saveCat(cat_sal);
      autreOperations.saveCat(cat_ach);
      autreOperations.saveCat(cat_cad);
      autreOperations.saveCat(cat_div);
      autreOperations.saveCat(cat_san);
      autreOperations.saveCat(cat_spo);
      autreOperations.saveCat(cat_tra);
      autreOperations.saveCat(cat_voy);
      autreOperations.saveCat(cat_edu);
      autreOperations.saveCat(cat_uti);
      autreOperations.saveCat(cat_vet);

    }
}

