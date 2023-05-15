import 'dart:async';
import 'dart:convert';
import 'package:bankopinion/src/pages/homeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SignUpView3 extends StatefulWidget {
  final String password1;
  final String email;

  SignUpView3({required this.password1, required this.email});

  @override
  State<SignUpView3> createState() => _SignUpView3State();
}

class _SignUpView3State extends State<SignUpView3> {
  var isValidName = false;
  var isValidSurname = false;
  var isValidUser = false;
  var body;
  var fecha;
  var errorRegistro = false;

  TextEditingController _dateController = TextEditingController(text: '');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchData() async {
    void sendBody(body) async {
      var registroUser = Uri.parse(
          'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/signIn');

      // ignore: unused_local_variable
      final response = await http.post(registroUser, body: jsonEncode(body));
    }
  }

  Future<void> addLog() async {
    var body = jsonEncode({"type": "SignUp"});

    var newView = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/logs/addlog');
    final response = await http.post(newView,
        body: body, headers: {"Content-Type": "application/json"});

    // var addNews = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                  initialDateTime: _date,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime value) {
                    _dateController.text =
                        DateFormat('dd/MM/yyyy').format(value);
                  },
                ),
              ),
            ));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_date);
      });
    }
  }

  final TextEditingController textController = TextEditingController(text: '');
  DateTime _date = DateTime.now();

  // ignore: prefer_final_fields
  var _name = '';
  var _surname = '';
  var _nickname = '';
  var edad;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: "");
    fetchData();
  }

  @override
  void dispose() {
    _dateController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 153, 116, 223),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("Paso 1",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                    const Icon(Icons.check_circle,
                        size: 30, color: Color.fromARGB(255, 153, 116, 223))
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 12), child: Text("")),
                    Container(
                      height: 3,
                      width: 120,
                      color: const Color.fromARGB(255, 153, 116, 223),
                    )
                  ],
                ),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("Paso 2",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                    const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 153, 116, 223),
                      size: 44,
                    )
                  ],
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    Text("Datos personales",
                        style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                width: kIsWeb ? 400 : null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 4, top: 35),
                              child: Text("Nombre",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 72, 72, 72),
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                  if (_name != "") {
                                    isValidName = true;
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Alejandro",
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 4, top: 35),
                              child: Text("Apellidos",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 72, 72, 72),
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                _surname = value;
                                if (_surname != "") {
                                  isValidSurname = true;
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: "Rodrigo Romero",
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 4, top: 35),
                              child: Text("Nombre de usuario",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 72, 72, 72),
                                      fontWeight: FontWeight.bold))),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: PopupMenuButton<String>(
                              icon: const Icon(Icons.info,
                                  color: Color.fromARGB(255, 153, 116, 223)),
                              onSelected: (String result) {
                                // ignore: avoid_print
                                print(result);
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Info',
                                  child: Text(
                                      'Saldrá como predetermindado para proteger tu identidad, sin embargo, posteriormente podrás elegir en tu perfil si prefieres que se muestre tu nombre real o el nombre de usuario en las preferencias de tu perfil.'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                              child: TextField(
                            controller: textController,
                            onChanged: (value) {
                              setState(() {
                                _nickname = value;
                                if (_nickname != "") {
                                  isValidUser = true;
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "_aless21",
                            ),
                          ))
                        ],
                      ),
                      _nickname != ''
                          ? RichText(
                              text: TextSpan(
                                text: _nickname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 153, 116, 223),
                                    fontSize: 14),

                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const TextSpan(
                                    text:
                                        " saldrá por defecto en tus comentarios",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            )
                          : const Text(""),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4, top: 35),
                            child: Text(
                              "Fecha de nacimiento",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 72, 72, 72),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: _selectDate,
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText:
                                        '${_date.day}-${_date.month}-${_date.year}',
                                  ),
                                  controller: _dateController,
                                  readOnly: true,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      errorRegistro == true
                          ? RichText(
                              text: const TextSpan(
                              text: "Se ha producido un error",
                              style: TextStyle(
                                  color: Color.fromARGB(143, 255, 0, 0),
                                  fontWeight: FontWeight.normal),
                            ))
                          : Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: isValidName &&
                                      isValidSurname &&
                                      isValidUser
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        //MANDAMOS EL BODY MEDIANTE UNA PETICIÓN POST
                                        var body = jsonEncode({
                                          "username": _nickname,
                                          "name": _name,
                                          "surname": _surname,
                                          "dateOfBirth": "2020-01-01",
                                          "email": widget.email,
                                          "password": widget.password1
                                        });

                                        print(body);

                                        var registroUser = Uri.parse(
                                            'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/signUp');

                                        var response = await http.post(
                                            registroUser,
                                            body: body,
                                            headers: {
                                              "Content-Type": "application/json"
                                            });

                                        print(
                                            "statusCode: ${response.statusCode}");
                                        print(
                                            "response.body: ${response.body}");
                                        var responseErr =
                                            json.decode(response.body);

                                        var responseError =
                                            responseErr["status"];

                                        if (response.statusCode == 200 &&
                                            responseError != 400) {
                                          addLog();
                                          Map<String, dynamic> responseData =
                                              json.decode(response.body);
                                          var token = responseData["session"]
                                              ["access_token"];
                                          var refresh_token =
                                              responseData["session"]
                                                  ["refresh_token"];

                                          var prefs = await SharedPreferences
                                              .getInstance();

                                          prefs.setString('jwt', token);
                                          prefs.setString(
                                              'refresh_token', refresh_token);

                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PageHomePage()));
                                        } else {
                                          setState(() {
                                            errorRegistro = true;
                                          });
                                          print(
                                              "Error al registrar usuario, codigo de estado: ${response.statusCode}");
                                          // maneja el error segun el codigo de estado
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 120, vertical: 14),
                                        backgroundColor:
                                            Color.fromARGB(255, 153, 116, 223),
                                      ),
                                      child: const Text("Siguiente",
                                          style: TextStyle(fontSize: 16)))
                                  : ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 120, vertical: 14),
                                        backgroundColor: const Color.fromARGB(
                                            127, 154, 116, 223),
                                      ),
                                      child: const Text("Siguiente",
                                          style: TextStyle(fontSize: 16))))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
