import 'dart:async';
import 'package:bankopinion/src/auth/loginView.dart';
import 'package:bankopinion/src/auth/signup1.dart';
import 'package:bankopinion/src/auth/signup2.dart';
import 'package:bankopinion/src/auth/signup3.dart';
import 'package:bankopinion/src/pages/configuraci%C3%B3n.dart';
import 'package:bankopinion/src/pages/homeView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authServices/refreshToken.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  String? jwt;

  @override
  void initState() {
    super.initState();
    _getJWT();
    // var refresh = AuthService();
    // refresh.refreshToken();
     
  }

  Future<void> _getJWT() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwt = prefs.getString('jwt');
    });
  }

  late TextEditingController _controller;

  var banks = [];
  var prefs;

  Future<void> fetchData() async {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
            child: Container(
              child: Image.asset(
                'assets/images/imageStartView.jpeg',
                width: double.infinity,
                height: 300.0,
                //fit: BoxFit.cover,
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                  "Encuentra las mejores recomentaciones de sucursales bancarias",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Container(
                    child: ElevatedButton(
                  onPressed: (() {
                    
    //                 var refresh = AuthService();
    // refresh.refreshToken();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageHomePage()));
                    
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 153, 116, 223),
                  ),
                  child: Text(
                          "Opinar sobre sucursales",
                      style: TextStyle(fontSize: 16)),
                )))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                    child: ElevatedButton(
                  onPressed: (() {
                    if (jwt == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginView()));
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 55, vertical: 14),
                    backgroundColor:                       
                    jwt == null
                        ?const Color.fromARGB(255, 153, 116, 223)
                        :Color.fromARGB(67, 154, 116, 223)
                  ),
                  child: Text(
                      jwt == null
                          ? "Iniciar sesión o registrarme"
                          : "Ya has iniciado sesión",
                      style: TextStyle(fontSize: 16)),
                )))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child:
                    // ignore: prefer_const_constructors
                    InkWell(
                        onTap: () {},
                        // ignore: prefer_const_constructors
                        child: Text("Sobre nosotros",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 153, 116, 223),
                                decoration: TextDecoration.underline))))
          ],
        )
      ]),
    );
  }
}
