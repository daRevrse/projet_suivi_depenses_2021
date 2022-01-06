import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_suivi_de_depenses2021/Database/user_operations.dart';
import 'package:projet_suivi_de_depenses2021/pages/page_connexion.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_creation/nouvelle_transaction.dart';
import 'package:projet_suivi_de_depenses2021/pages/pseudo_pages/pages_list/page_list_transactions.dart';
import 'package:projet_suivi_de_depenses2021/pages/root_app_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/userModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.grey[300]
      ),
      home: SplashScreen(),
    );
  }
}

User? user;
var userId;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  UserOperations userOperations = UserOperations();

  @override
  void initState() {
    // TODO: implement initState
    getValidationData().whenComplete(() async{
      Timer(Duration(seconds: 3), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => (userId == null ? PageConnexion() : RootPage(user: user!,))));
      });
    });
    super.initState();
  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _userId = sharedPreferences.getInt("userId");
    setState(() {
      userId = _userId;
    });
    User _user = await userOperations.getUser(userId);
    setState(() {
      user = _user;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // logo here
                  Image.asset(
                    'assets/575271.png',
                    height: 120,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
            Container(
                child: Image.asset("assets/paygate.jpg"),
              )
          ],
        ),
      ),
    );
  }
}

