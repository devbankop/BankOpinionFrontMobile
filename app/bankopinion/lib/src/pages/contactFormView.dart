// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:bankopinion/src/pages/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class contactFormView extends StatefulWidget {
  const contactFormView({Key? key}) : super(key: key);

  @override
  contactFormViewState createState() => contactFormViewState();
}

class contactFormViewState extends State<contactFormView> {
  late SharedPreferences _prefs;
  bool _isLocationEnabled = false;

  bool err = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendForm() async {
    var body = jsonEncode({
      "name": _nameController.text,
      "email": _emailController.text,
      "subject": _subjectController.text,
      "message": _messageController.text
    });

    var form = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/contact/');
    final response = await http
        .post(form, body: body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
      _showAlertDialog();
    }
    // var addNews = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
  }

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _formKey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10),
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
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Color.fromARGB(255, 153, 116, 223),
                                )),
                          )),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Formulario de Contacto",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 55, 11, 137),
                                fontWeight: FontWeight.w800),
                                softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Nombre:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        controller: _nameController,
                        onChanged: (String value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nombre al que poder referirnos',
                        ),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Correo electrónico:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.info,
                                size: 20,
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
                                    'Necesitaremos tu correo cuando tengamos que ponernos en contacto contigo para solucionar tus dudas lo antes posible'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: TextField(
                        controller: _emailController,
                        onChanged: (String value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Correo al que contactarte',
                        ),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Asunto:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        controller: _subjectController,
                        onChanged: (String value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Danos una pequeña descripción',
                        ),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Mensaje:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        controller: _messageController,
                        onChanged: (String value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Por favor, cuéntanos cuál es tu duda, sugerencia o problema con el que te has encontrado usando BankOpinion',
                        ),
                        maxLines: 50,
                        minLines: 10,
                      ),
                    ),
                    err == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: RichText(
                              text: const TextSpan(
                                text: "Debes completar todos los campos",
                                style: TextStyle(
                                    color: Color.fromARGB(143, 255, 0, 0),
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: (() async {
                                if (_nameController.text != "" &&
                                    _emailController.text != "" &&
                                    _subjectController.text != "" &&
                                    _messageController.text != "") {
                                  sendForm();
                                  setState(() {
                                    err = false;
                                  });
                                } else {
                                  setState(() {
                                    err = true;
                                  });
                                }
                              }),
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 50),
                                backgroundColor:
                                    const Color.fromARGB(255, 153, 116, 223),
                              ),
                              child: const Text("Enviar",
                                  style: TextStyle(fontSize: 16)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(56, 233, 221, 255),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "¡Muchas gracias, tus comentarios nos ayudan a mejorar!",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Nos pondremos en contacto contigo en breve a través del correo que nos proporcionaste.",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
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
                                  const Color.fromARGB(255, 153, 116, 223)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfigView()),
                            );
                          },
                          child: const Text(
                            "Continuar",
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
