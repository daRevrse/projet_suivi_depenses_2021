import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/autre_operations.dart';
import 'package:projet_suivi_de_depenses2021/Database/transactions_operations.dart';
import 'package:projet_suivi_de_depenses2021/Models/transactionModel.dart';
import 'package:projet_suivi_de_depenses2021/Models/userModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';


class PageStats extends StatefulWidget {
  final User currentUser;
  const PageStats({Key? key,required this.currentUser}) : super(key: key);
  @override
  _PageStatsState createState() => _PageStatsState();
}

class _PageStatsState extends State<PageStats> {

  TransactionOperations transactionOperations = TransactionOperations();
  AutreOperations autreOperations = AutreOperations();

  late List<charts.Series<Task, String>> _seriesPieData;
  late List<charts.Series<Task, String>> _seriesPieDataR;
  late List<charts.Series<Task, String>> _seriesPieDataD;


  late double totalRev;
  late double totalDep;
  late double catRPercent;
  late double catDPercent;

  bool isZoomOut = true;

  Future refresh()async{
    double _total = (await transactionOperations.getCount())!;
    double _totalRev = (await transactionOperations.getCountByType("Revenu",widget.currentUser))!;
    double _totalDep = (await transactionOperations.getCountByType("Dépense",widget.currentUser))!;

    var listCatD = (await autreOperations.getCatByType("Dépense", widget.currentUser))!;
    var listCatR = (await autreOperations.getCatByType("Revenu", widget.currentUser))!;

    setState(() {
      totalDep = ((_totalDep * 100)/_total).floorToDouble();
      totalRev = ((_totalRev * 100)/_total).floorToDouble();
    });

    _seriesPieData = <charts.Series<Task, String>>[];

    getData();

    _seriesPieDataR = <charts.Series<Task, String>>[];
    _seriesPieDataD = <charts.Series<Task, String>>[];

    List<Task> pieDataR = [];
    List<Task> pieDataD = [];

    for(int i = 0; i < listCatR.length; i++){
      double _catCount = (await transactionOperations.getCountByCat("Revenu", widget.currentUser, listCatR[i]))!;

      setState(() {
        catRPercent = ((_catCount * 100) / _totalRev).floorToDouble();
      });

      Task _task = new Task('${listCatR[i].nom}', catRPercent, Color(listCatR[i].color!));
      pieDataR.add(_task);
    }

    for(int i = 0; i < listCatD.length; i++){
      double _catCount = (await transactionOperations.getCountByCat("Dépense", widget.currentUser, listCatD[i]))!;

      setState(() {
        catDPercent = ((_catCount * 100) / _totalDep).floorToDouble();
      });

      Task _task = new Task('${listCatD[i].nom}', catDPercent, Color(listCatD[i].color!));
      pieDataD.add(_task);
    }



    _seriesPieDataR.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: pieDataR,
        labelAccessorFn: (Task row, _) => '${row.task}\n ${row.taskvalue} %',
      ),
    );

    _seriesPieDataD.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: pieDataD,
        labelAccessorFn: (Task row, _) => '${row.task}\n ${row.taskvalue} %',
      ),
    );


  }

  getData(){

    var piedata = [
      new Task('Revenus', totalRev, Color(0xff109618)),
      new Task('Dépenses', totalDep, Color(0xffdc3912)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.task}\n ${row.taskvalue} %',
      ),
    );

  }

  @override
  void initState() {

    refresh();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
            automaticallyImplyLeading: false,
            title: FittedBox(child: Text('${widget.currentUser.nom}'),alignment: Alignment.center,),
            titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal,
            actions: [IconButton(onPressed: (){
              setState(() {
                isZoomOut ? isZoomOut = false : isZoomOut = true;
              });
            }, icon: Icon((isZoomOut) ? Icons.zoom_in : Icons.zoom_out))],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.teal[800],
                child: Text("Statistiques",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            )
        ),
      ),
      body: isZoomOut ? Center(
        child: Container(
          child: FutureBuilder<List<TransactionModel>?>(
              future: transactionOperations.getTransactions(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TransactionModel>?> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart,size: 140,color: Colors.grey,),
                        Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
                      ],
                    ),

                  ));
                }else {
                  return snapshot.data!.isEmpty
                      ? Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bar_chart,size: 140,color: Colors.grey,),
                            Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
                          ],
                        ),

                      ))
                      : Container(
                    color: Colors.white,
                    child: charts.PieChart(
                        _seriesPieData,
                        animate: true,
                        animationDuration: Duration(milliseconds: 500),
                        /*behaviors: [
                          new charts.DatumLegend(
                            outsideJustification: charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color: charts.MaterialPalette.purple.shadeDefault,
                                fontFamily: 'Georgia',
                                fontSize: 11),
                          )
                        ],*/
                        defaultRenderer: charts.ArcRendererConfig(
                            arcWidth: 100,
                            arcRendererDecorators: [
                              charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside)
                            ]
                        )),
                  );
                }
              }),
        ),
      ) : Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: FutureBuilder<List<TransactionModel>?>(
                    future: transactionOperations.getTransactionsByType(widget.currentUser, "Revenu"),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TransactionModel>?> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bar_chart,size: 70,color: Colors.grey,),
                              Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
                            ],
                          ),

                        ));
                      }else {
                        return snapshot.data!.isEmpty
                            ? Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bar_chart,size: 70,color: Colors.grey,),
                                  Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
                                ],
                              ),

                            ))
                            : Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              child: charts.PieChart(
                                  _seriesPieDataR,
                                  animate: true,
                                  animationDuration: Duration(milliseconds: 500),
                                  /*behaviors: [
                                  new charts.DatumLegend(
                                    outsideJustification: charts.OutsideJustification.endDrawArea,
                                    horizontalFirst: false,
                                    desiredMaxRows: 2,
                                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                    entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.purple.shadeDefault,
                                        fontFamily: 'Georgia',
                                        fontSize: 11),
                                  )
                                ],*/
                                  defaultRenderer: charts.ArcRendererConfig(
                                      arcWidth: 70,
                                      arcRendererDecorators: [
                                        charts.ArcLabelDecorator(
                                            labelPosition: charts.ArcLabelPosition.inside)
                                      ]
                                  )),
                            ),
                            Center(
                              child: Text(
                                "Revenus",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: FutureBuilder<List<TransactionModel>?>(
                    future: transactionOperations.getTransactionsByType(widget.currentUser, "Dépense"),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TransactionModel>?> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bar_chart,size: 70,color: Colors.grey,),
                              Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
                            ],
                          ),

                        ));
                      }else {
                        return snapshot.data!.isEmpty
                            ? Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bar_chart,size: 70,color: Colors.grey,),
                                  Text("Aucune statistique",style: TextStyle(fontSize: 40,color: Colors.grey),)
                                ],
                              ),

                            ))
                            : Stack(
                          children: [
                            Container(
                              child: charts.PieChart(
                                  _seriesPieDataD,
                                  animate: true,
                                  animationDuration: Duration(milliseconds: 500),
                                  /*behaviors: [
                                  new charts.DatumLegend(
                                    outsideJustification: charts.OutsideJustification.endDrawArea,
                                    horizontalFirst: false,
                                    desiredMaxRows: 2,
                                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                    entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.purple.shadeDefault,
                                        fontFamily: 'Georgia',
                                        fontSize: 11),
                                  )
                                ],*/
                                  defaultRenderer: charts.ArcRendererConfig(
                                      arcWidth: 70,
                                      arcRendererDecorators: [
                                        charts.ArcLabelDecorator(
                                            labelPosition: charts.ArcLabelPosition.inside)
                                      ]
                                  )),
                            ),
                            Center(
                              child: Text(
                                "Dépenses",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}