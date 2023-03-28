import 'dart:async';
import 'package:bankopinion/src/about/terms.dart';
import 'package:bankopinion/src/pages/profile.dart';
import 'package:bankopinion/src/pages/startView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable Components/bottomBar.dart';

import '../about/aboutus.dart';
import '../about/privacyPolicy.dart';
import '../auth/loginView.dart';
import '../authServices/refreshToken.dart';
import 'prefs.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  late TextEditingController _controller;

  String? jwt;
  String? userRole;
  String? refresh_token;

  @override
  void initState() {
    super.initState();

  if(jwt != null && jwt != '')
  {
        var refresh = AuthService();
    refresh.refreshToken();
  }
    _getRole();
    _getJWT();
  }


   Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      userRole = prefs.getString('userRole');
  }
  Future<void> _getJWT() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwt = prefs.getString('jwt');
      refresh_token = prefs.getString('refresh_token');

    });
  }
Future<void> _deleteJWT() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      
      prefs.remove('jwt');
      prefs.remove('refresh_token');
      jwt = null;

    });
  }

 

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        bottomNavigationBar: BottomBar(),
        body: 
        SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: 
                  Center(
                    child: Container(
                      width: 800,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("AJUSTES",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color.fromARGB(255, 55, 11, 137),
                                        fontWeight: FontWeight.bold))
                              ],
                            )),
                            jwt != null && jwt != ''
                             ?
                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: 
                               Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(25, 55, 11, 137),
                                  border: Border.all(
                                    color: Color.fromARGB(168, 55, 11, 137),
                                    width: .6,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color:
                                              Color.fromARGB(168, 55, 11, 137),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text("Información personal",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 55, 11, 137))))
                                      ],
                                    )),
                              )
                              
                            ))
                            : Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: InkWell(
                              onTap: () {
                                _showAlertDialog();         
                              },
                              child: 
                               Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(29, 122, 122, 122),
                                  border: Border.all(
                                    color: Color.fromARGB(168, 122, 122, 122),
                                    width: .6,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color:
                                              Color.fromARGB(168, 132, 132, 132),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text("Información personal",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(255, 132, 132, 132))))
                                      ],
                                    )),
                              )
                              
                            )),

                        //APARTADO DE PREFERENCIAS
jwt != null && jwt != ''
                             ?
                        Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrefsView()));
                          },
                          child: Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),

                                color: Color.fromARGB(25, 55, 11, 137),
                                border: Border.all(
                                  color: Color.fromARGB(168, 55, 11, 137),
                                  width: .6,
                                ),
                              ),
                              child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.settings_accessibility,
                                  color: Color.fromARGB(168, 55, 11, 137),),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Preferencias",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 55, 11, 137)
                                    )))
                                ],
                              )),
                              ),
                        ))
                        : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: InkWell(
                          onTap: () {
                            _showAlertDialog();    
                          },
                          child: Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),

                                color: Color.fromARGB(29, 122, 122, 122),
                                border: Border.all(
                                  color: Color.fromARGB(168, 132, 132, 132),
                                  width: .6,
                                ),
                              ),
                              child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(Icons.settings_accessibility,
                                  color: Color.fromARGB(168, 122, 122, 122)),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Preferencias",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 132, 132, 132)
                                    )))
                                ],
                              )),
                              ),
                        )),

                        Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("INFORMACIÓN LEGAL",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color.fromARGB(255, 55, 11, 137),
                                        fontWeight: FontWeight.bold))
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => aboutUsView()));
                                      },
                                        child: Text("Sobre nosotros",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 55, 11, 137),
                                            )))
                                  ])),
                              Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                         Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => termsView()));
                                      },
                                        child: Text(
                                            "Términos y condiciones de uso",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 55, 11, 137),
                                            )))
                                  ])),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 80),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => privacyPolicyView()));
                                      },
                                        child: Text("Política de privacidad",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 55, 11, 137),
                                            )))
                                  ])),
                            ])),
                            
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: jwt != null && jwt != ''
                                  ? ElevatedButton(

                                      onPressed: () {
                                        _deleteJWT();
                                                                                  print(userRole);

                                          userRole = 'user';
                                       
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StartView()));
                                        
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 110, vertical: 14),
                                       backgroundColor: userRole == 'superAdmin' ? Color.fromARGB(255, 223, 116, 116) :Color.fromARGB(130, 55, 11, 137),
                                      ),
                                      child: const Text("Cerrar sesión",
                                          style: TextStyle(fontSize: 16)))
                                  : ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                            userRole = 'user';

                                        });
                                              print(userRole);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 110, vertical: 14),
                                        backgroundColor: userRole == 'superAdmin' ? Color.fromARGB(255, 223, 116, 116) :const Color.fromARGB(255, 153, 116, 223),
                                      ),
                                      child: const Text("Iniciar sesión",
                                          style: TextStyle(fontSize: 16))),
                            ))
                      ])
                    )
                  )
                )));}
        

    void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              color: Color.fromARGB(56, 233, 221, 255),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Primero debes iniciar sesión o registrarte en caso de no tener una cuenta.",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 153, 116, 223)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Vale",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
