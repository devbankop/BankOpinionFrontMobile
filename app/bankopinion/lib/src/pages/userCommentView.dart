// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bankopinion/src/auth/loginView.dart';
import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable Components/bottomBar.dart';
import '../Reusable Components/ratingStarsBranch.dart';
import 'homeView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userCommentView extends StatefulWidget {
  var bank;

  userCommentView({required this.bank});

  @override
  State<userCommentView> createState() => userCommentViewState();
}

class userCommentViewState extends State<userCommentView> {
  Future<void> fetchData() async {}

  String? jwt;
  String? refresh_token;

  var agradecimientos = [
    "¡Muchas gracias, desde BankOpinion agradecemos enormemente tu opinión!",
    "¡Muchas gracias, tu opinión ayudará a otras personas interesadas en esta sucursal!",
    "¡Muchas gracias, tus comentarios nos ayudan a mejorar!",
    "¡Muchas gracias, cada opinión es de gran ayuda para los demás!"
  ];
  var aleatorio;
  var rng = new Random();
  agradecimientoAleatorio() {
    aleatorio = agradecimientos[rng.nextInt(agradecimientos.length)];
    return aleatorio;
  }

  @override
  void initState() {
    super.initState();
    _getRefreshToken().then((_) => _getJWT()).then((_) {
      print("object");
      print('$refresh_token');
    });
  }

  double rating = 1.0;
  String textoReview = "";
  bool checkShowUser = false;

  Future<void> _getJWT() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    jwt = preferences.getString('jwt');
    refresh_token = preferences.getString('refresh_token');
  }

  Future<void> _getRefreshToken() async {
    var sendRefreshToken = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/newSession');

    var response = await http.get(sendRefreshToken,
        headers: {HttpHeaders.authorizationHeader: "$refresh_token"});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        jwt = jsonResponse["jwt"];
        refresh_token = jsonResponse["refresh_token"];
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onChanged(bool? value) {
    setState(() {
      checkShowUser = value ?? false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomBar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(children: [
            Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(children: <Widget>[
                            Image.network(
                              'https://maps.googleapis.com/maps/api/streetview?location=${widget.bank["location"]["lat"]},${widget.bank["location"]["lng"]}&size=1200x800&key=AIzaSyCQctW3M3O3TUSj5oDr9BLYNEwm0Vxm4Ak',
                              fit: BoxFit.cover,
                              width: screenWidth,
                              height: 265.0,
                              //fit: BoxFit.cover,
                            ),
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
                          ])
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25, left: 17, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.bank["branchName"],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text(widget.bank["address"],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ))
                              ],
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 4),
                                child: Row(
                                  children: [
                                    Column(children: [
                                      StatmentRatings(bank: widget.bank)
                                    ]),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Text(
                                              "(${widget.bank["branchRating"]})",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 66, 66, 66),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(right: 15, left: 15),
                              height: 1,
                              width: screenWidth - 30,
                              color: const Color.fromARGB(255, 138, 138, 138),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                    initialRating: rating,
                                    minRating: 1,
                                    itemSize: 60.0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    // ignore: prefer_const_constructors
                                    itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (value) {
                                      setState(() {
                                        rating = value;
                                      });

                                      print(rating.toString());
                                    })
                              ])),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Text("Déjanos tu comentario",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                textoReview = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '',
                            ),
                            maxLines: 18,
                            minLines: 10,
                          )),

                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(children: <Widget>[
                            Checkbox(
                              value: checkShowUser,
                              activeColor: Color.fromARGB(255, 153, 116, 223),
                              checkColor: Colors.white,
                              tristate: false,
                              onChanged: _onChanged,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Text("Mostrar con el nombre real",
                                style: TextStyle(
                                    color: !checkShowUser
                                        ? Color.fromARGB(255, 0, 0, 0)
                                        : Color.fromARGB(255, 153, 116, 223))),
                          ])),

                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  constraints: BoxConstraints(
                                      minWidth: 300,
                                      maxWidth:
                                          (MediaQuery.of(context).size.width *
                                                  1) -
                                              30),
                                  child: jwt != null && jwt != ""
                                      ? ElevatedButton(
                                          onPressed: (() async {
                                            _showAlertDialog();
                                            var body = jsonEncode({
                                              "review": textoReview,
                                              "reviewRating": rating,
                                              "showUser": checkShowUser
                                            });

                                            print(body);

                                            var sendReview = Uri.parse(
                                                'https://bankopinion-backend-development-3vucy.ondigitalocean.app/reviews/insertReview/' +
                                                    widget.bank["id"]
                                                        .toString());

                                            if (jwt != null) {
                                              var response = await http.post(
                                                sendReview,
                                                body: body,
                                                headers: {
                                                  HttpHeaders
                                                          .authorizationHeader:
                                                      "$jwt"
                                                },
                                              );
                                              print("$jwt");
                                              print(response.statusCode);
                                              print(response.body);

                                              if (response.statusCode == 200) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PageHomePage()),
                                                );
                                              }
                                            } else {
                                              print("jwt es null");
                                            }
                                          }),
                                          style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            padding: const EdgeInsets.all(12),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 153, 116, 223),
                                          ),
                                          child: const Text("Enviar",
                                              style: TextStyle(fontSize: 16)))
                                      : ElevatedButton(
                                          onPressed: (() async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginView()),
                                            );
                                          }),
                                          style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            padding: const EdgeInsets.all(12),
                                            backgroundColor: Color.fromARGB(
                                                127, 154, 116, 223),
                                          ),
                                          child: const Text(
                                              "Primero debes iniciar sesión",
                                              style: TextStyle(fontSize: 16))))
                            ],
                          ))
                    ]))
          ])
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
                    agradecimientoAleatorio(),
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
                            Navigator.of(context).pop();
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
