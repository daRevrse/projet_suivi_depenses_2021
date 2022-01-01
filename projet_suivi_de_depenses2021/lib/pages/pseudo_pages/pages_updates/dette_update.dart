import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_affichage/page_afficher_dette.dart';

DateTime date = DateTime.now();
TimeOfDay time = TimeOfDay.fromDateTime(date);

class ModifierDette extends StatefulWidget {
  final User user;
  final DetteModel dette;
  const ModifierDette({Key? key,required this.user,required this.dette}) : super(key: key);

  @override
  _ModifierDette createState() => _ModifierDette();
}

class _ModifierDette extends State<ModifierDette> {

  AutreOperations autreOperations = AutreOperations();
  TransactionOperations transactionOperations = TransactionOperations();
  TextEditingController controller = new TextEditingController();

  TextEditingController descController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  num restant = 0;

  void calcRest() async {
    var total_remb = (await transactionOperations.getRestant(widget.user,widget.dette))[0]['TOTAL'];

    //print(total_sum);
    setState(() {
      if(total_remb!=null) {
        restant = widget.dette.montant! - total_remb;
      } else {
        restant = widget.dette.montant!;

      }
    });
  }

  @override
  void initState() {
    setState(() {
      descController.text = widget.dette.description!;
      montantController.text = widget.dette.montant!.toString();
      date = widget.dette.datetime!;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Dette"),
        backgroundColor: Colors.teal,
        actions: [
          RaisedButton(
            elevation: 10,
            color: Colors.white,
            onPressed: () async {
              calcRest();
              DetteModel dette = DetteModel(widget.dette.creancier,descController.text,int.parse(montantController.text),restant,date,widget.user.id);
              await autreOperations.updateDette(dette);

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> PageDette(currentUser: widget.user,currentDette: widget.dette)));

            },
            child: Text("Modifier"),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 50,left: 50,right: 50),
            child:
            Column(
                children: [
                  Text("Modifier cette dette",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                        onChanged: (value){
                          //montantController.text = value;
                          setState(() {
                            widget.dette.description = value;
                          });
                        }
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: montantController,
                      decoration: InputDecoration(
                        hintText: "Nouveau montant",
                        labelText: 'Montant',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                        onChanged: (value){
                          //montantController.text = value;
                          setState(() {
                            widget.dette.montant = int.parse(value);
                          });
                        }
                    ),
                  ),
                ]
            )
        ),
      ),

    );
  }
}
