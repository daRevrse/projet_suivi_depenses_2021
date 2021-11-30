import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class connexion extends StatefulWidget {
  const connexion({Key? key}) : super(key: key);

  @override
  _connexion createState() => _connexion();
}

class _connexion extends State<connexion> {

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body:
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children:[
              Column(
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(Icons.access_alarm),
                ],
              ),
              Row(children: [Text("Ajouter compte")],),
              Row(children: [Text("Ajouter compte")],),
              Row(children: [TextField(
                controller: controller,
                onChanged: (String string){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  labelText: "Saisissez le nom",
                  fillColor: Colors.blue
                ),

              )],
              ),
            ],
          ),
        ]
            ),

    );
  }
}
