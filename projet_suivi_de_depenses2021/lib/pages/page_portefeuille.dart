import 'package:flutter/material.dart';

class Portefeuille extends StatefulWidget {
  const Portefeuille({Key? key}) : super(key: key);

  @override
  _PortefeuilleState createState() => _PortefeuilleState();
}

class _PortefeuilleState extends State<Portefeuille> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
      ),
    );
  }
}
