import 'dart:async';
import 'package:bankopinion/src/auth/loginView.dart';
import 'package:bankopinion/src/auth/signup1.dart';

import 'package:bankopinion/src/pages/news.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  String? jwt;
  String? userRole;


  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
    _getJWT();
    _getRole();
  //    SharedPreferences.getInstance().then((value) {
  //   prefs = value;
  // }
  // );
    // var refresh = AuthService();
    // refresh.refreshToken();
     
  }


Future<void> _getCurrentLocation() async {
// Solicita el permiso de ubicación
var status = await Permission.location.request();

if( await Permission.locationWhenInUse.serviceStatus.isEnabled )
{
status = PermissionStatus.granted;
prefs.setBool('isLocationEnabled', true);
} else if( await Permission.locationWhenInUse.isPermanentlyDenied )
{
status = PermissionStatus.permanentlyDenied;
prefs.setBool('isLocationEnabled', false);
}

if (status != PermissionStatus.granted) {
print('Permiso de ubicación denegado');
prefs.setBool('isLocationEnabled', false);
return;
}

// Obtiene la posición actual del usuario
var position = await Geolocator.getCurrentPosition();
print('Latitud: ${position.latitude}, Longitud: ${position.longitude}');
}




  Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(jwt == null)
      prefs.setString('userRole', 'user');
        userRole = 'user';

      jwt = prefs.getString('jwt');
    });
  }
  Future<void> _getJWT() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwt = prefs.getString('jwt');
    });
  }


  var banks = [];
  var prefs;

  Future<void> fetchData() async {}

  @override 
  void dispose() {
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

        Padding(padding: EdgeInsets.only(top: 50),
        child: Text("BankOpinion",
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 122, 93, 178)
        ))),
        Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
            child: Container(
              child: Image.asset(
                'assets/images/imageStartView.png',
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
            Padding(padding: EdgeInsets.only(top: 5),
            child: Text("¿PROBLEMAS CON TU BANCO?",
            softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Color.fromARGB(255, 55, 18, 125),
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text(
                  "Haz que tu opinión cuente y mantente al día sobre el mundo financiero",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.5)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Container(
                    child: ElevatedButton(
                  onPressed: (() {
                  
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsView()));
                    
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 153, 116, 223),
                  ),
                  child: Text(
                          "Acceder",
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
                padding: const EdgeInsets.only(top: kIsWeb ? 20 : 60),
                child:
                    // ignore: prefer_const_constructors
                    InkWell(
                        onTap: () {

                           if (jwt == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginView()));
                    }
                        },
                        // ignore: prefer_const_constructors
                        child: Text("Inicia sesión",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 153, 116, 223),
                                decoration: TextDecoration.underline)))),
            Padding(
                padding: const EdgeInsets.only(top: kIsWeb ? 20 : 60),
                child:
            Text("    ó    ",
            style: const TextStyle(
            color: Color.fromARGB(255, 153, 116, 223)))),

            Padding(
                padding: const EdgeInsets.only(top: kIsWeb ? 20 : 60),
                child:
                    // ignore: prefer_const_constructors
                    InkWell(
                        onTap: () {

                           if (jwt == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpView1()));
                    }
                        },
                        // ignore: prefer_const_constructors
                        child: Text("Regístrate",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 153, 116, 223),
                                decoration: TextDecoration.underline))))
          ],
        )
      ]),
    );
  }
}
