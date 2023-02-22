import 'dart:async';
import 'dart:convert';
import 'package:bankopinion/src/auth/signup1.dart';
import 'package:bankopinion/src/pages/homeView.dart';
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
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
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
                  const Text("INICIO DE SESIÓN",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 55, 11, 137),
                          fontWeight: FontWeight.bold))
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20),
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
                        child: Text("Contraseña",
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
                          passwd = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Contraseña'),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    )
                  ],
                ),
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
                                    {
                                    "email": correo, 
                                    "password": passwd
                                    });

                                print(body);

                                var loginUser = Uri.parse(
                                    'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/signIn');

                                var response = await http.post(loginUser,
                                    body: body,
                                    headers: {
                                      "Content-Type": "application/json"
                                    });

                                print("statusCode: ${response.statusCode}");
                                print("response.body: ${response.body}");

                                if (response.statusCode == 200) {
                                  Map<String, dynamic> responseData =
                                      json.decode(response.body);
                                  print("hola");
                                  var token =
                                      responseData["session"]["access_token"];
                                  var refreshToken =
                                      responseData["session"]["refresh_token"];
                                  var expiresIn = responseData["session"]["expires_in"];
                                                  var userRole = responseData["userProfile"]["userRole"].toString();


                                 

                                  List<dynamic> userBranchesFavorites = responseData["userProfile"]["userBranchesFavorites"];

                               


                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  print(token);

                                  prefs.setString('jwt', token);
                                  prefs.setString('refresh_token', refreshToken);
                                  prefs.setInt('expires_in', expiresIn);
                                  prefs.setString('userRole', userRole);


                                  print(userRole);


                                  if (prefs.getString('jwt') != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PageHomePage()));
                                  }
                                }
                              }),
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 130, vertical: 14),
                                backgroundColor:
                                    const Color.fromARGB(255, 153, 116, 223),
                              ),
                              child: const Text("Acceder",
                                  style: TextStyle(fontSize: 16)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: (() {}),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  color: Color.fromARGB(46, 35, 0, 100),
                                  width: .5,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 14),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.login,
                                  color: Colors.black,
                                ),
                                Text(
                                  " Iniciar sesión con Google",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
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
                    padding: EdgeInsets.only(top: 40),
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
          ),
        ])));
  }
}
