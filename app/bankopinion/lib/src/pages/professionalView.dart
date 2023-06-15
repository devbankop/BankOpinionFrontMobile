import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Reusable Components/ratingStarsUser.dart';

class professionalView extends StatefulWidget {
  var id;
  var title;
  var image;
  var schedule;
  var address;
  var city;
  var mail;
  var rating;
  var ratingAv;
  var description;
  var amount;
  var type;
  var phone;
  var web;
  var chat;

  professionalView(
      {
      required this.id,
      required this.title,
      required this.image,
      required this.schedule,
      required this.address,
      required this.city,
      required this.mail,
      required this.rating,
      required this.ratingAv,
      required this.description,
      required this.amount,
      required this.type,
      required this.phone,
      required this.web,
      required this.chat});

  @override
  professionalViewState createState() => professionalViewState();
}

class professionalViewState extends State<professionalView> {
  var ratingAv;
  var rating;

  var ratingg;

  @override
  void initState() {
    super.initState();
    ratingFunc();
  }

  Future<void> addLog() async {
    var body = jsonEncode({"type": "Consulta a ${widget.title}"});

    var newView = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/logs/addlog');
    final response = await http.post(newView,
        body: body, headers: {"Content-Type": "application/json"});

    // var addNews = jsonDecode(response.body);
    print(response.statusCode);
    //print(response.body);
  }

  Future<void> ratingFunc() async {
    var ratingAve = [];
    ratingAve.addAll(widget.rating);
    print(ratingAve);
    ratingAve.add(rating);

    ratingAv = ((ratingAve.reduce((value, element) => value + element)) / ratingAve.length).toStringAsFixed(2);
    var body = jsonEncode({
      "rating": ratingAve,
      "ratingAv": ratingAv
    });
    print(ratingAv);

    var sendRating = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/professionals/${widget.id}');
    final response = await http.put(sendRating,
        body: body, headers: {"Content-Type": "application/json"});

    // var addNews = jsonDecode(response.body);
    print(response.statusCode);

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 1;

    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60.0,
                        height: 60.0,
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 9, 112),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                widget.image,
                                width: 140,
                                height: 140.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${widget.type} en ${widget.city}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          SizedBox(
                              height: 7), // Espacio vertical entre las filas
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(widget.address,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 3), // Espacio vertical entre las filas

                          InkWell(
                            onTap: () {
                              if (widget.web != "") {
                                launchUrl(Uri.parse(widget.web));
                              }
                            },
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(widget.web,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 28, 83, 128))),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                              height: 5), // Espacio vertical entre las filas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               
                              StatmentRatingsUser(rating: widget.ratingAv),
                              Text("(${widget.rating.length.toString()})",
                              style: TextStyle(fontSize: 12))
                              
                            ],
                          ),
                          SizedBox(height: 5),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       widget.amount,
                          //       style: TextStyle(
                          //         color: Colors.green,
                          //         fontSize: 28,
                          //         fontWeight: FontWeight.w800,
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      Text(
                        widget.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                        child: SizedBox(
                          width: screenWidth,
                          child: Text(
                            "Horarios de ${widget.title}:",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic),
                          ),
                        )),
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 14, right: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Lunes a Viernes",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Icon(Icons.arrow_right_alt),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        widget.schedule[0],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      widget.schedule[1] != ""
                                          ? Text(
                                              widget.schedule[1],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      SizedBox(height: 0),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              widget.schedule[2] != "" ||
                                      widget.schedule[3] != ""
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Sábados",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Icon(Icons.arrow_right_alt),
                                        SizedBox(width: 10),
                                        Column(
                                          children: [
                                            widget.schedule[2] != ""
                                                ? Text(
                                                    widget.schedule[2],
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            widget.schedule[3] != ""
                                                ? Text(
                                                    widget.schedule[0],
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 14, right: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 14, right: 14),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Contacto",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 14, right: 14),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 14, right: 14),
                                child: widget.phone != ""
                                    ? ElevatedButton(
                                        onPressed: (() async {
                                          var prefijo = 34;
                                          launch(
                                              'tel:+{$prefijo}${widget.phone}');
                                        }),
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 25),
                                          backgroundColor: const Color.fromARGB(
                                              255, 153, 116, 223),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.phone),
                                            const Text("Telefónico",
                                                style: TextStyle(fontSize: 16))
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink()),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 14, right: 14),
                                child: widget.mail != ""
                                    ? ElevatedButton(
                                        onPressed: (() async {
                                          String recipientEmail = widget.mail;
                                          String subject =
                                              'Consulta a ${widget.title} desde BankOpinion';
                                          String body = '';

                                          String emailUri =
                                              'mailto:$recipientEmail?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
                                          launch(emailUri);
                                        }),
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 25),
                                          backgroundColor: const Color.fromARGB(
                                              255, 153, 116, 223),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.mail),
                                            const Text("Correo",
                                                style: TextStyle(fontSize: 16))
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40, left: 14, right: 14, bottom: 20),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Valorar",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                          RatingBar.builder(
                              initialRating: 3,
                              minRating: 0,
                              itemSize: 45.0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              // ignore: prefer_const_constructors
                              itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              onRatingUpdate: (value) {
                                setState(() {
                                  rating = value;
                                  print(rating);
                                });

                                // print(rating.toString());
                              }),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5, left: 14, right: 14, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () async {

                                ratingFunc();

                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Fondo blanco
                                onPrimary: Color.fromARGB(
                                    220, 42, 7, 107), // Letras de color
                                onSurface: Color.fromARGB(
                                    220, 42, 7, 107), // Bordes de color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: Color.fromARGB(
                                        220, 42, 7, 107), // Bordes de color
                                    width: .7, // Ancho de los bordes
                                  ),
                                ),
                              ),
                              child: Text('Enviar valoración'),
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
