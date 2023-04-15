import 'dart:async';
import 'dart:convert';
import 'package:bankopinion/src/auth/signup1.dart';
import 'package:bankopinion/src/pages/homeView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _controller = TextEditingController();

  var banks = [];
  var correo;
  var passwd;
  var _isObscure = true;
  var error404 = false;
  var lostPasswd;

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
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                child: Image.asset(
                  'assets/images/loginImage.webp',
                  width: double.infinity,
                  height: 260.0,
                  //fit: BoxFit.cover,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(kIsWeb ? "INICIO  DE  SESIÓN" : "INICIO DE SESIÓN",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 55, 11, 137),
                          fontWeight: FontWeight.bold))
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
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
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              correo = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ejemplo@correo.com'),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4, top: 15),
                          child: Text(
                            "Contraseña",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              passwd = value;
                            },
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
                                border: OutlineInputBorder(),
                                hintText: 'Contraseña'),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kIsWeb ? 20 : 20),
                      child:
                          // ignore: prefer_const_constructors
                          InkWell(
                        onTap: () {
                          _showAlertDialog();
                        },
                        // ignore: prefer_const_constructors
                        child: Text(
                          "Recuperar contraseña",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 153, 116, 223),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    error404 == true
                        ? RichText(
                            text: const TextSpan(
                            text: "Credenciales de acceso incorrectas",
                            style: TextStyle(
                                color: Color.fromARGB(143, 255, 0, 0),
                                fontWeight: FontWeight.normal),
                          ))
                        : Text(""),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: (() async {
                                    var body = jsonEncode(
                                        {"email": correo, "password": passwd});

                                    var loginUser = Uri.parse(
                                        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/signIn');

                                    var response = await http.post(loginUser,
                                        body: body,
                                        headers: {
                                          "Content-Type": "application/json"
                                        });

                                    print("statusCode: ${response.statusCode}");

                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> responseData =
                                          json.decode(response.body);
                                      var token = responseData["session"]
                                          ["access_token"];
                                      var refreshToken = responseData["session"]
                                          ["refresh_token"];
                                      var expiresIn =
                                          responseData["session"]["expires_in"];
                                      var userRole = responseData["userProfile"]
                                              ["userRole"]
                                          .toString();

                                      List<dynamic> userBranchesFavorites =
                                          responseData["userProfile"]
                                              ["userBranchesFavorites"];

                                      var prefs =
                                          await SharedPreferences.getInstance();

                                      prefs.setString('jwt', token);
                                      prefs.setString(
                                          'refresh_token', refreshToken);
                                      prefs.setInt('expires_in', expiresIn);
                                      prefs.setString('userRole', userRole);

                                      if (prefs.getString('jwt') != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PageHomePage()));
                                      }
                                    }
                                    if (response.statusCode == 404)
                                      setState(() {
                                        error404 = true;
                                      });
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 130, vertical: 14),
                                    backgroundColor: const Color.fromARGB(
                                        255, 153, 116, 223),
                                  ),
                                  child: const Text("Acceder",
                                      style: TextStyle(fontSize: 16)))
                            ],
                          ),
                        ),

                        //Inicio con Google
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
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
                        //               style: TextStyle(
                        //                   fontSize: 16, color: Colors.black),
                        //             )
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                              color: Color.fromARGB(255, 161, 161, 161),
                              height: 1,
                              width: 130,
                            ),
                            Text("  O  "),
                            Container(
                              color: Color.fromARGB(255, 161, 161, 161),
                              height: 1,
                              width: 130,
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 50),
                        child: ElevatedButton(
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpView1()));
                            }),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 14),
                              backgroundColor:
                                  const Color.fromARGB(255, 153, 116, 223),
                            ),
                            child: const Text("Registrarse",
                                style: TextStyle(fontSize: 16))))
                  ],
                ),
              )),
        ]))));
  }

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
                    "Por favor, indícanos un correo existente al que enviar los pasos de restablecimiento de contraseña.",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: prefer_const_constructors
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              lostPasswd = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'ejemplo@correo.com'),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      )
                    ],
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
                          onPressed: () async {
                            var body = jsonEncode({"email": lostPasswd});

                            var getNewPasswd = Uri.parse(
                                'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/resetPassword');
                            final response = await http.post(getNewPasswd,
                                body: body,
                                headers: {"Content-Type": "application/json"});

                            if (response.statusCode == 200) {
                              Navigator.of(context).pop();
                            } else {
                              print(response.statusCode);
                            }
                          },
                          child: Text(
                            "Enviar",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
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
