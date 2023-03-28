import 'dart:async';
import 'dart:convert';

import 'package:bankopinion/src/pages/homeView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool _isChecked = true;
  String? jwt;

                  
var userId;
var name;
var surname;
var nickname;
var email;

var userData;

bool error = false;

  @override
  void initState() {
    super.initState();
    _getUserProfile(); 

  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }


Future<void> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwt = prefs.getString('jwt');
      userId = prefs.getString('user_id').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      nickname = prefs.getString('nickname').toString();
      email = prefs.getString('email').toString();

    });


  }




  Future<void> _getUserProfile() async {

        final prefs = await SharedPreferences.getInstance();
        jwt = prefs.getString("jwt");
        var getUser = Uri.parse(
            'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/getUser');

        var response =
            await http.get(getUser, headers: {"Authorization": '$jwt'});
  print(response.statusCode);
              if (response.statusCode == 200) {
          //RECUPERAMOS VALORES DE LA RESPUESTA DE LA PETICIÓN
                var responseData = json.decode(response.body);

                setState(() {
                   userData = responseData["userProfile"];
                });
                print(userData);
              

    }                                  
    }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Row(
                children: [
                  SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(5),
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 153, 116, 223),
                            )),
                      )),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 25, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("INFORMACIÓN PERSONAL",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 55, 11, 137),
                          fontWeight: FontWeight.bold))
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            // ignore: sized_box_for_whitespace
            child: Container(
              width: double.infinity,
              height: 150.0,
              child: const Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 153, 116, 223),
                  size: 150),
              //fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        // ignore: unnecessary_const
                        child: const Text("Nombre",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                           Text(userData["name"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              )),
                              //Icon(Icons.lock),

                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 250,
                ),
                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 4),
                        // ignore: unnecessary_const
                        child: const Text("Apellidos",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                           Text(userData["surname"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 250,
                ),
                Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 30),
                        // ignore: unnecessary_const
                        child: const Text("Nombre de usuario",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                           Text(userData["username"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                        Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 250,
                ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 30),
                        // ignore: unnecessary_const
                        child: const Text("Email",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                           Text(userData["email"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 250,
                ),
                // Padding(
                //     padding: EdgeInsets.only(left: 10),
                //     child: Row(children: <Widget>[
                //       Checkbox(
                //         value: _isChecked,
                //         activeColor: Color.fromARGB(255, 153, 116, 223),
                //         checkColor: Colors.white,
                //         tristate: false,
                //         onChanged: _onChanged,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //       Text("Mostrar nombre de usuario en comentarios",
                //       style: TextStyle(
                //         color: !_isChecked ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 153, 116, 223)
                //       )),
                //     ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 30),
                        // ignore: unnecessary_const
                        child: const Text("Contraseña",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                          const Text("******",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 250,
                ),

                Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ElevatedButton(
                            onPressed: (() async {
                                _showAlertDialog();
                            }),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 14),
                                  backgroundColor: Colors.red
                            ),
                            child: Row(
                              children: const [
                                
                                Text(
                                  "Eliminar cuenta",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )),
                      ])),


                      Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      error == true
                  ? RichText(
                      text: TextSpan(
                          text: "Se ha producido un error eliminando el usuario",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(128, 255, 0, 0),
                              fontSize: 14),

                          )): Text("")
                      ]))

              ])),
        ])));
  }
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
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
                    "¿Deseas eliminar tu usuario con todos los datos y comentarios asociados al mismo?",
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
                                  Color.fromARGB(255, 224, 66, 66)),
                          onPressed: () async {
                            

                            final prefs = await SharedPreferences.getInstance();
                          jwt = prefs.getString("jwt");
                          var deleteUser = Uri.parse(
                              'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/deleteUser');

                          var response =
                              await http.delete(deleteUser, headers: {"Authorization": '$jwt'});

                                print(response.statusCode);
                                             

                              if(response.statusCode == 200){

                                 setState(() {
                                  prefs.remove('jwt');
                                  prefs.remove('refresh_token');
                                  jwt = null;

                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageHomePage()));
                              } else {

                                Navigator.pop(context);

                                setState(() {
                                  error = true;  
                                });
                              
                              }

                          },
                          child: Text(
                            "Eliminar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        
                      ),
                    ),
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 153, 116, 223)),
                          onPressed: () async {                        

                            Navigator.pop(context);

                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
