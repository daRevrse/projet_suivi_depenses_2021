import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/compte_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/compteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewCompte extends StatefulWidget {
  final User user;
  const NewCompte({Key? key,required this.user}) : super(key: key);

  @override
  _NewCompte createState() => _NewCompte();
}

class _NewCompte extends State<NewCompte> {

  CompteOperations compteOperations = CompteOperations();
  TextEditingController controller = new TextEditingController();

  Color color = Colors.teal;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color _color) => setState(() => color = _color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  TextEditingController nomController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController montantController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Compte"),
        backgroundColor: Colors.teal,
        actions: [
          RaisedButton(
            elevation: 10,
            color: Colors.white,
            onPressed: () async {
              CompteModel compte = CompteModel(nomController.text,descController.text,int.parse(montantController.text),color.value,widget.user.id);
              await compteOperations.saveCompte(compte);

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> RootPage(user: widget.user,)));

            },
            child: Text("Enregistrer"),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 50,left: 50,right: 50),
            child:
            Column(
                children: [
                  Text("Creer un compte",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: nomController,
                      decoration: InputDecoration(
                        hintText: 'entrer  nom',
                        labelText: 'Nom du compte ',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: montantController,
                      decoration: InputDecoration(
                        hintText: 'Entre le solde du compte',
                        labelText: 'Solde',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child: TextButton(
                      child: Container(height: 50,width: 180,decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3,
                              // changes position of shadow
                            ),
                          ]),),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Pick a color!'),
                            /*content: BlockColorPickerExample(
                                          pickerColor: color,
                                          onColorChanged: changeColor,
                                          pickerColors: currentColors,
                                          onColorsChanged: changeColors,
                                          colorHistory: colorHistory,
                                        ),*/
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlockPicker(
                                  pickerColor: color,
                                  onColorChanged: changeColor,
                                ),
                                TextButton(
                                  child: Text("Select"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]
            )
        ),
      ),

    );
  }
}
