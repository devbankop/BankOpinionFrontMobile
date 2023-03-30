import 'dart:async';
import 'package:bankopinion/src/auth/signup3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpView2 extends StatefulWidget {
    final String email;

  SignUpView2({required this.email});

  @override
  State<SignUpView2> createState() => _SignUpView2State();
}

class _SignUpView2State extends State<SignUpView2> {
  Future<void> fetchData() async {}

  var _isObscure = true;
  var _isObscure2 = true;

  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _isValid2 = false;

  //VARIABLES DE COMPROBACIONES DE CONTRASEÑA
  String password1 = '';
  var _password2 = '';
  bool _isDeleting = false;
  var _passwordErrorNumber = null;
  var _passwordErrorMinus = null;
  var _passwordErrorMayus = null;
  var _passwordErrorLength = null;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(child: 
        SingleChildScrollView(
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
                const Icon(Icons.circle,
                    size: 44, color: Color.fromARGB(255, 153, 116, 223))
              ],
            ),
            Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 12), child: Text("")),
                Container(
                  height: 3,
                  width: 120,
                  color: const Color.fromARGB(116, 176, 176, 176),
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
                            color: Color.fromARGB(116, 176, 176, 176),
                            fontWeight: FontWeight.bold))),
                const Icon(Icons.circle,
                    color: Color.fromARGB(116, 176, 176, 176))
              ],
            ),
          ]),
          Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    Text("Crea una contraseña",
                        style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold)),
                  ])),
          Container(
            width: kIsWeb ? 400 : null,
            child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 45, left: 30),
                        child: Text("Contraseña",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.lock),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextField(
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            hintText: "Introduce tu nueva contraseña",
                          ),
                          onChanged: (String value) {

                            password1 = value;
                              _passwordErrorNumber = !_isDeleting &&
                                      RegExp(r'^(?=.*[0-9])')
                                          .hasMatch(password1)
                                  ? "Al menos un número"
                                  : null;

                              _passwordErrorMinus = !_isDeleting &&
                                      RegExp(r'^(?=.*[a-z])')
                                          .hasMatch(password1)
                                  ? "Al menos una letra minúscula"
                                  : null;

                              _passwordErrorMayus = !_isDeleting &&
                                      RegExp(r'^(?=.*[A-Z])')
                                          .hasMatch(password1)
                                  ? "Al menos una letra mayúscula"
                                  : null;
                              _passwordErrorLength =
                                  !_isDeleting && password1.length >= 8
                                      ? "Al menos 8 caracteres"
                                      : null;



                            setState(() {
                              
                              if(_passwordErrorLength != null && _passwordErrorMayus != null && _passwordErrorMinus != null && _passwordErrorNumber != null)
                              _isValid = true;
                            });
                             
                          },
                          
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 30, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "La contraseña debe contener:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 128, 128, 128),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //DEBE CONTENER UN NÚMERO

                        _passwordErrorNumber != null
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  Text(
                                    _passwordErrorNumber,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const Text(
                                    "Al menos un número",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),

                        //DEBE CONTENER UNA LETRA MINÚSCULA

                        _passwordErrorMinus != null
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  Text(
                                    _passwordErrorMinus,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const Text(
                                    "Al menos una letra minúscula",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),

                        //DEBE CONTENER UNA LETRA MAYÚSCULA

                        _passwordErrorMayus != null
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  Text(
                                    _passwordErrorMayus,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const Text(
                                    "Al menos una letra mayúscula",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),

                        //DEBE CONTENER 8 CARACTERES

                        _passwordErrorLength != null
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  Text(
                                    _passwordErrorLength,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const Text(
                                    "Al menos 8 caracteres",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 45, left: 30),
                        child: Text("Confirma la contraseña",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.lock)),
                    Expanded(
                        child: TextField(
                      obscureText: _isObscure2,
                      onChanged: (value) {
                        
                      setState(() {
                        _password2 = value;

                        password1 == _password2
                        ?  _isValid2 = true
                        :  _isValid2 == false;

                      });
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                            
                          },
                          child: Icon(_isObscure2
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: "Introduce de nuevo tu contraseña",
                      ),
                    ))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                             ElevatedButton(
                                onPressed: 
                                     () {
                                        if (_isValid2 && password1 == _password2) {
                                          
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpView3(password1: password1, email: widget.email)));
                                        } else {

                                        }
                                      },
                                    
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 130, vertical: 14),
                                  backgroundColor:
                                      _isValid2 && password1 == _password2 ? const Color.fromARGB(255, 153, 116, 223) : Color.fromARGB(121, 154, 116, 223),
                                ),
                                child: const Text("Siguiente",
                                    style: TextStyle(fontSize: 16)))
                            
                      ],
                    ))
              ],
            ),
          )
          )
        ])))
        
        );
  }
}
