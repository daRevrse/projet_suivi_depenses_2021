import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_suivi_de_depenses2021/Database/dette_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/detteModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';

DateTime date = DateTime.now();
TimeOfDay time = TimeOfDay.fromDateTime(date);

class NewDette extends StatefulWidget {
  final User user;
  const NewDette({Key? key,required this.user}) : super(key: key);

  @override
  _NewDette createState() => _NewDette();
}

class _NewDette extends State<NewDette> {

  DetteOperations detteOperations = DetteOperations();
  TextEditingController controller = new TextEditingController();

  TextEditingController creancierController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController dateController = TextEditingController()..text = DateFormat.yMd().format(date);


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
              DetteModel dette = DetteModel(creancierController.text,descController.text,int.parse(montantController.text),int.parse(montantController.text),date,widget.user.id);
              await detteOperations.saveDette(dette);

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
                  Text("Creer une dette",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25),
                    child:
                    TextField(
                      controller: creancierController,
                      decoration: InputDecoration(
                        hintText: 'Je dois à ...',
                        labelText: 'Créancier',
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
                        hintText: "La dette s'élève à...",
                        labelText: 'Montant',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25,left: 50,right: 50),
                      child: TextButton(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  labelText: 'Date',
                                  hintText: DateFormat.yMd().format(date),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color:Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            //Text(DateFormat.yMd().format(date),style: TextStyle(decoration: TextDecoration.underline),),
                            Icon(Icons.calendar_today)
                          ],
                        ),

                        onPressed: (){
                          showDatePicker(
                              context: context,
                              initialDate: date == null ? DateTime.now() : date,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now()
                          ).then((value) {
                            setState(() {
                              date = value!;
                              dateController.text = DateFormat.yMd().format(date);
                            });
                          });
                        },

                      )
                  ),
                ]
            )
        ),
      ),

    );
  }
}
