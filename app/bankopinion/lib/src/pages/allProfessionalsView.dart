import 'dart:async';
import 'dart:convert';
import 'package:bankopinion/src/pages/professionalView.dart';
import 'package:bankopinion/src/pages/profile.dart';
import 'package:bankopinion/src/pages/requestProfessional.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Reusable Components/bottomBar.dart';
import 'package:http/http.dart' as http;

import '../Reusable Components/ratingStarsUser.dart';
import '../authServices/refreshToken.dart';

class allProfessionalsView extends StatefulWidget {
  const allProfessionalsView({super.key});

  @override
  State<allProfessionalsView> createState() => allProfessionalsViewState();
}

class allProfessionalsViewState extends State<allProfessionalsView> {
  late TextEditingController _controller;

  String? jwt;
  String? userRole;
  String? refresh_token;
  String? selectedField;
  var pros = [];
  String selectedType = "";
  var search = false;


  @override
  void initState() {
    super.initState();
    getProfessionals();
    if (jwt != null && jwt != '') {
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

  Future<void> addLog() async {
    var body = jsonEncode({"type": "All Professionals"});

    var newView = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/logs/addlog');
    final response = await http.post(newView,
        body: body, headers: {"Content-Type": "application/json"});

    // var addNews = jsonDecode(response.body);
    print(response.statusCode);
    //print(response.body);
  }

Future<void> getProfessionals() async {
  var getProfessionals = Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/professionals/');
  final response = await http.get(getProfessionals);

  print(response.statusCode);

  Map<String, dynamic> responseData = jsonDecode(response.body);
  print(responseData);
  setState(() {
    pros = [];
    if (responseData['professionals'] != null &&
        responseData['professionals'] is List) { // Verificar si es una lista
      List<dynamic> professionals = responseData['professionals'];
      for (var professional in professionals) {
        if (professional['approved'] == true) {
          if (selectedType.isEmpty || professional['type'] == selectedType) {
            pros.add(professional);
          }
        }
      }
    }
  });

  print(pros);
}




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
    double screenWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomBar(),
      body: Column(
        children: [
          Container(
            height: 85,
            color: userRole == 'superAdmin'
                ? Color.fromARGB(255, 194, 65, 65)
                : Color.fromARGB(255, 153, 116, 223),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Profesionales legales",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {
                  _showAlertDialog();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: '¿Eres profesional?',
                            style: TextStyle(
                              color: Color.fromARGB(250, 55, 11, 137),
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Container(
                          width: 110,
                          height: .7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              color: Color.fromARGB(158, 55, 11, 137),
                              width: .4,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: Container(
                width: screenWidth,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var field in [
                                      'Abogados',
                                      'Juristas',
                                      'Gestores',
                                      'Notarios',
                                    ])
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 6),
                                        child: InkWell(
                                          onTap: () {
                                             setState(() {
                                            if (selectedType == field) {
                                              getProfessionals();
                                              selectedType = ""; // Deseleccionar el elemento actual
                                            } else {
                                              getProfessionals();
                                              selectedType = field; // Seleccionar el nuevo elemento
                                              print(selectedType);
                                            }
                                          });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: selectedType == field
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      168, 55, 11, 137),
                                              border: Border.all(
                                                color: selectedType == field
                                                    ? Color.fromARGB(
                                                        168, 55, 11, 137)
                                                    : Color.fromARGB(
                                                        168, 55, 11, 137),
                                                width: .6,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Text(
                                                    field,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: selectedType == field
                                                          ? Color.fromARGB(
                                                              168, 55, 11, 137)
                                                          : Color.fromARGB(255,
                                                              255, 255, 255),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      
                                      getProfessionals();
                                      setState(() {
                                        search = !search;

                                      });

                                    },
                                    child: Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(168, 55, 11, 137),
                                          width: 1.2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          size: 25,
                                          color:
                                              Color.fromARGB(168, 55, 11, 137),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                          search == true
                          ? 
                              SizedBox(
                                width: 250,
                                child:
                                  TextField(
                                      //controller: ,
                                      // onEditingComplete: () {
                                        
                                      // },
                                      onChanged: (value) {
                                        setState(() async {

                                            final url = 'https://bankopinion-backend-development-3vucy.ondigitalocean.app/professionals/search?name=$value';

                                    try {
                                      final response =
                                          await http.get(Uri.parse(url));
                                      if (response.statusCode == 200) {
                                        // La solicitud se realizó con éxito
                                        Map<String, dynamic> responseData =
                                            jsonDecode(response.body);

                                        List<dynamic> professionals =
                                            responseData['professionals']
                                                ['data'];
                                        pros.clear();

                                        for (var professional
                                            in professionals) {
                                          if (professional['approved'] ==
                                              true) {
                                            if (selectedType.isEmpty ||
                                                professional['type'] ==
                                                    selectedType) {
                                              pros.add(professional);
                                            }
                                          }
                                        }

                                        if (value == "") {
                                          getProfessionals();
                                        }
                                      } else {
                                        // La solicitud no se realizó con éxito
                                        print(
                                            'Error en la solicitud GET: ${response.statusCode}');
                                              }
                                            } catch (error) {
                                              // Ocurrió un error al realizar la solicitud
                                              print('Error en la solicitud GET: $error');
                                            }


                                          // Acciones al enviar el valor del TextField
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black, // Color del borde inferior
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(168, 55, 11, 137), // Color del borde inferior cuando el TextField está seleccionado
                                            width: 2.0,
                                          ),
                                        ),
                                        hintText: 'Busca lo que necesitas',
                                      ),
                                      maxLines: 1,
                                      minLines: 1,
                                      cursorColor: Color.fromARGB(168, 55, 11, 137), // Color del cursor

                                    ),
                              )
                          : SizedBox.shrink(),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 5, left: 5),
                        child: RichText(
                          text: TextSpan(
                              text: pros.length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(168, 55, 11, 137),
                                  fontSize: 18),

                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const TextSpan(
                                  text: " resultados en",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                const TextSpan(
                                  text: " Valencia",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              itemCount: pros.length,
              itemBuilder: (context, index) {
                var professional = pros[index];
                return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                professionalView(
                                  id: pros.elementAt(index)["id"],
                                  type: pros.elementAt(index)["type"],
                                  title: pros.elementAt(index)["title"],
                                  description: pros.elementAt(index)["description"],
                                  address: pros.elementAt(index)["address"],
                                  city: pros.elementAt(index)["city"],
                                  schedule: pros.elementAt(index)["schedule"],
                                  image: pros.elementAt(index)["image"],
                                  rating: pros.elementAt(index)["rating"],
                                  ratingAv: pros.elementAt(index)["ratingAv"],
                                  amount: pros.elementAt(index)["amount"],
                                  phone: pros.elementAt(index)["phone"],
                                  mail: pros.elementAt(index)["mail"],
                                  web: pros.elementAt(index)["web"],
                                  chat: pros.elementAt(index)["chat"],
                                  
                                  
                                  ),
                          ),
                        );
                      },
                      child: Container(
                        height: 205,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color.fromARGB(24, 255, 255, 255),
                          border: Border.all(
                            color: Color.fromARGB(99, 55, 11, 137),
                            width: .4,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Container(
                                        width: 140,
                                        height: 140,
                                        child: Image.network(
                                          pros.elementAt(index)["image"],
                                          width: 140,
                                          height: 140.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children:  [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  "Horario:",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 55, 11, 137),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  pros.elementAt(index)["schedule"][0],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  pros.elementAt(index)["schedule"][1] != ""
                                                  ? pros.elementAt(index)["schedule"][1]
                                                  : "",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Container(
                                                  height: 40,
                                                  width: .8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Color.fromARGB(
                                                        24, 255, 255, 255),
                                                    border: Border.all(
                                                      color: Color.fromARGB(
                                                          99, 55, 11, 137),
                                                      width: .4,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Text(
                                                      "Contacto:",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 55, 11, 137),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    pros.elementAt(index)["phone"] != ""
                                                    ? Icon(
                                                      Icons.phone,
                                                       size: 18,
                                                   ) 
                                                    : SizedBox.shrink(),
                                                    pros.elementAt(index)["mail"] != ""
                                                    ? Icon(
                                                      Icons.mail,
                                                      size: 18,
                                                    ) 
                                                    : SizedBox.shrink(),
                                                    // Icon(
                                                    //   Icons.support_agent_sharp,
                                                    //   size: 18,
                                                    //)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 10, left: 5),
                                        child: 
                                        SizedBox(
                                          width: screenWidth * 0.57,
                                          child: Text(
                                          pros.elementAt(index)["title"],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                     ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start, 
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 10, left: 5),
                                        child: SizedBox(
                                          width: screenWidth * 0.58,
                                          child: Text(
                                            
                                            pros.elementAt(index)["description"],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 4,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Text(
                                              "Valoración: ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: 
                                          Row(
                                            children: [
                                              StatmentRatingsUser(rating: pros.elementAt(index)["ratingAv"].toDouble()),
                                              Text("(${pros.elementAt(index)["rating"].length.toString()})",
                                           style: TextStyle(fontSize: 12)),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     Padding(
                                      //       padding: EdgeInsets.only(top: 10),
                                      //       child: Text(
                                      //         "Honorarios:   ",
                                      //         style: TextStyle(
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.w600,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.only(top: 10),
                                      //       child: Text(
                                      //         pros.elementAt(index)["amount"],
                                      //         style: TextStyle(
                                      //           color: Colors.green,
                                      //           fontSize: 17,
                                      //           fontWeight: FontWeight.w800,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
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
                    "¿Eres un profesional y quieres que tus servicios aparezcan en la lista?\n\nEnvíanos una solicitud y pronto podrás formar parte.",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => requestProfessionalView(),
                              ),
                            );
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
