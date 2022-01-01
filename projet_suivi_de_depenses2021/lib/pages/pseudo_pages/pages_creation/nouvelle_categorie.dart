import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/categorieModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Categorie extends StatefulWidget {
  final User currentUser;
  const Categorie({Key? key,required this.currentUser}) : super(key: key);

  @override
  _Categorie createState() => _Categorie();
}

class _Categorie extends State<Categorie> {

  Color color = Colors.teal;
  String typeText = " ";
  bool isRev = false;
  bool isDep = false;
  TextEditingController nomController = TextEditingController();
  AutreOperations autreOperations = AutreOperations();

  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color _color) => setState(() => color = _color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Categorie"),
        backgroundColor: Colors.teal,
        actions: [
          RaisedButton(
            elevation: 10,
            color: Colors.white,
            onPressed: ()async{
              CategorieModel _cat = CategorieModel(nomController.text, typeText, color.value, widget.currentUser.id);
              await autreOperations.saveCat(_cat);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> Categorie(currentUser: widget.currentUser)));
            },
            child: Text("Enregistrer"),
          )

        ],
      ),
      body: SingleChildScrollView(
        child:
        DefaultTabController(
          length: 2,
          child:
          Padding(padding: EdgeInsets.zero,
              child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text("Enregistrer une categorie",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25),
                            child:
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextField(
                                      controller: nomController,
                                      decoration: InputDecoration(
                                        hintText: 'Nom de la categorie',
                                        labelText: 'Entrer le nom',

                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:Colors.black,
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                TextButton(child: CircleAvatar(backgroundColor: color,),onPressed: (){
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

                                },),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25),
                            child: Row(
                              children: [
                              Expanded(
                                child: CheckboxListTile(
                                  onChanged: (value){
                                    setState(() {
                                      isRev = value!;
                                      isDep = false;
                                      typeText = "Revenu";
                                    });
                                  },
                                  value: isRev,
                                  title: Text("Revenu"),
                                  activeColor: Colors.deepOrange,
                                ),
                              ),
                              Expanded(
                                  child: CheckboxListTile(
                                onChanged: (value){
                                  setState(() {
                                    isDep = value!;
                                    isRev = false;
                                    typeText = "Dépense";
                                  });
                                },
                                value: isDep,
                                title: Text("Dépense"),
                                activeColor: Colors.deepOrange,
                              )),
                            ],)
                          ),
                        ],
                      ),
                    ),
                    /*Padding(padding: EdgeInsets.only(top: 25, bottom: 25),
                      child:
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Icon',
                          labelText: 'Ajouter une icon',

                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),*/
                    SizedBox(height: 15),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text("Vos categories",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.teal[100],
                                  borderRadius: BorderRadiusDirectional.circular(5)
                              ),

                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TabBar(
                                    indicator: BoxDecoration(color: Colors.teal,
                                        borderRadius: BorderRadiusDirectional.circular(5)
                                    ),
                                    tabs:[
                                      Tab(text:'Revenu'),
                                      Tab(text:'Dépense'),
                                    ]
                                ),
                              )
                          ),
                          SizedBox(
                              height: 350,
                              width: 500,
                              child:TabBarView(
                                children: [
                                  Container(
                                      height:100,
                                      width:150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadiusDirectional.circular(10)
                                      ),
                                      child: SingleChildScrollView(
                                        child: FutureBuilder<List<CategorieModel>?>(
                                            future: autreOperations.getCatByType("Revenu",widget.currentUser),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<CategorieModel>?> snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                                                      Text("Aucune catégorie",style: TextStyle(fontSize: 20,color: Colors.grey),)
                                                    ],
                                                  ),
                                                ));
                                              }else {
                                                return snapshot.data!.isEmpty
                                                    ? Center(child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                                                      Text("Aucune catégorie",style: TextStyle(fontSize: 20,color: Colors.grey),)
                                                    ],
                                                  ),

                                                ))
                                                    : ListView(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: snapshot.data!.map((cat) {
                                                    return Card(
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius.circular(15),
                                                                bottomRight: Radius.circular(15),
                                                              )
                                                          ),
                                                          child: ListTile(
                                                            leading: CircleAvatar(backgroundColor: Color(cat.color!),),
                                                            title: Text('${cat.nom}'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              }
                                            }),
                                      ),
                                  ),
                                  Container(
                                      height:100,
                                      width:100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadiusDirectional.circular(10)
                                      ),
                                      child: SingleChildScrollView(
                                        child: FutureBuilder<List<CategorieModel>?>(
                                            future: autreOperations.getCatByType("Dépense",widget.currentUser),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<CategorieModel>?> snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                                                      Text("Aucune catégorie",style: TextStyle(fontSize: 20,color: Colors.grey),)
                                                    ],
                                                  ),
                                                ));
                                              }else {
                                                return snapshot.data!.isEmpty
                                                    ? Center(child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.swap_horiz,size: 70,color: Colors.grey,),
                                                      Text("Aucune transaction",style: TextStyle(fontSize: 20,color: Colors.grey),)
                                                    ],
                                                  ),

                                                ))
                                                    : ListView(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: snapshot.data!.map((cat) {
                                                    return Card(
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius.circular(15),
                                                                bottomRight: Radius.circular(15),
                                                              )
                                                          ),
                                                          child: ListTile(
                                                            leading: CircleAvatar(backgroundColor: Color(cat.color!),),
                                                            title: Text('${cat.nom}'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              }
                                            }),
                                      ),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),

                  ]
              )
          ),

        ),
      ),
    );
  }
}
