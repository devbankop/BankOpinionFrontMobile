import 'dart:async';

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

  @override
  void initState() {
    super.initState();
    getUserProfile();
    print(name);
    
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
                    padding: EdgeInsets.only(top: 10, left: 28),
                    child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                           Text(name.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              )),
                              //Icon(Icons.lock),

                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 300,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 25),
                        // ignore: unnecessary_const
                        child: const Text("Apellidos",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 28),
                    child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                           Text(surname.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 300,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 25),
                        // ignore: unnecessary_const
                        child: const Text("Nombre de usuario",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 28),
                    child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                           Text(nickname.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                        Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 300,
                ),
                        Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 25),
                        // ignore: unnecessary_const
                        child: const Text("Email",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 28),
                    child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Icon(Icons.lock),
                           Text(email.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 81, 81),
                              ))
                        ])),
                Container(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1,
                  width: 300,
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
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 25),
                        // ignore: unnecessary_const
                        child: const Text("Contraseña",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Row(
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
                  width: 300,
                ),
              ])),
        ])));
  }
}
