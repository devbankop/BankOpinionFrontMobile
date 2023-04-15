import 'dart:async';
import 'package:bankopinion/src/auth/signup2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUpView1 extends StatefulWidget {
  SignUpView1({super.key});

  @override
  State<SignUpView1> createState() => _SignUpView1State();
}

class _SignUpView1State extends State<SignUpView1> {
  late TextEditingController _controller;
  final TextEditingController emailTextController = TextEditingController();

  var checkEmailError = null;
  bool showError = false;
  String email = "";
  bool isValid = false;

  bool emailValid = false;

  String emailError = "";

  Future<void> fetchData() async {}

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
        body: Center(
          child: SingleChildScrollView(
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
              padding: const EdgeInsets.only(),
              child: Container(
                child: Image.asset(
                  'assets/images/loginImage.webp',
                  width: double.infinity,
                  height: 300.0,
                  //fit: BoxFit.cover,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, top: 15, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("Regístrate para no perderte nada",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 55, 11, 137),
                          fontWeight: FontWeight.bold))
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: kIsWeb ? 400 : null,
                    child: Column(
                      children: [
                        Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        // ignore: unnecessary_const
                        child: const Text("Email",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: emailTextController,
                      onChanged: (String value) {
                        setState(() {                 
                            email = value;  

                            isValid = EmailValidator.validate(email);
                    
                        });
                        
                        
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'ejemplo@correo.com',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),
                      ],
                    )
                ),
                !emailValid
                    ? Row(
                        children: [
                          Text(
                            "",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Email incorrecto",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        isValid
                              ? ElevatedButton(
                                  onPressed: (() {
                                      setState(() {
                                        emailValid == true;
                                      });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpView2(email: email)));
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 130, vertical: 14),
                                    backgroundColor: const Color.fromARGB(
                                        255, 153, 116, 223),
                                  ),
                                  child: const Text("Siguiente",
                                      style: TextStyle(fontSize: 16)))
                              : ElevatedButton(
                                  onPressed: (() {}),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 130, vertical: 14),
                                    backgroundColor: const Color.fromARGB(127, 154, 116, 223),
                                  ),
                                  child: const Text("Siguiente",
                                      style: TextStyle(fontSize: 16)))
                        ],
                      ),
                    ),
                  ],
                ),
                // Padding(
                //     padding: EdgeInsets.only(top: 40),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       // ignore: prefer_const_literals_to_create_immutables
                //       children: [
                //         Container(
                //           color: Color.fromARGB(255, 161, 161, 161),
                //           height: 1,
                //           width: 130,
                //         ),
                //         Text("  O  "),
                //         Container(
                //           color: Color.fromARGB(255, 161, 161, 161),
                //           height: 1,
                //           width: 130,
                //         )
                //       ],
                //     )),

        //INICIO CON GOOGLE
                // Padding(
                //   padding: const EdgeInsets.only(top: 40),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       ElevatedButton(
                //         onPressed: (() {}),
                //         style: ElevatedButton.styleFrom(
                //           shape: const StadiumBorder(
                //             side: BorderSide(
                //               color: Color.fromARGB(46, 35, 0, 100),
                //               width: .5,
                //             ),
                //           ),
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 55, vertical: 14),
                //           backgroundColor:
                //               const Color.fromARGB(255, 255, 255, 255),
                //         ),
                //         child: Row(
                //           children: const [
                //             Icon(
                //               Icons.login,
                //               color: Colors.black,
                //             ),
                //             Text(
                //               " Iniciar sesión con Google",
                //               style:
                //                   TextStyle(fontSize: 16, color: Colors.black),
                //             )
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ]))
        )
        );
  }
}
