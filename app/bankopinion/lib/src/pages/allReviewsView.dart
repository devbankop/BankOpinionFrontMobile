// ignore: file_names
import 'dart:convert';
// import 'dart:ffi';

import 'package:bankopinion/src/Reusable%20Components/ratingStarsUser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable Components/bottomBar.dart';
import '../Reusable Components/linearBars.dart';
import '../Reusable Components/ratingStarsBranch.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;

import '../authServices/refreshToken.dart';
import 'homeView.dart';
import 'userCommentView.dart';

class allReviews extends StatefulWidget {
  var bank;

  allReviews({required this.bank});

  @override
  State<allReviews> createState() => _allReviewsState();
}

class _allReviewsState extends State<allReviews> {
  var bank;
  var rating = 0;
  var index;
  var branchPhoto;
  String? jwt;
  var likes;
  String? totalLikes;
  late List<dynamic> userFavoriteComments = [];
  String? userRole;

  void initState() {
    super.initState();
    Jiffy.locale('es');
    Jiffy().yMMMMEEEEdjm;

    getUserProfile();
    _getRole();
  }

  Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('userRole');
  }

  Future<void> getUserProfile() async {
    if (jwt != null && jwt != '') {
      final prefs = await SharedPreferences.getInstance();
      jwt = prefs.getString("jwt");
      var getFavorites = Uri.parse(
          'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/getUser');

      var response =
          await http.get(getFavorites, headers: {"Authorization": '$jwt'});

      if (response.statusCode == 200) {
        //RECUPERAMOS VALORES DE LA RESPUESTA DE LA PETICIÓN
        Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          userFavoriteComments =
              responseData["userProfile"]["userReviewsLikes"];
          prefs.setStringList('favoriteComments',
              userFavoriteComments.map((e) => json.encode(e)).toList());
        });
      }
    }
  }

  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(children: [
          Column(
            children: [
              Row(
                children: [
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
                              //branchPhoto = bank["googleMapsUrl"],

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
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 255, 255),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: userRole ==
                                                          'superAdmin'
                                                      ? Color.fromARGB(
                                                          255, 223, 116, 116)
                                                      : const Color.fromARGB(
                                                          255, 153, 116, 223),
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
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  margin: const EdgeInsets.only(right: 15, left: 15),
                  height: 1,
                  width: screenWidth - 30,
                  color: const Color.fromARGB(255, 138, 138, 138),
                ),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 3),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Resumen de opiniones",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              )),
          Row(
            children: [linearBars(bank: widget.bank)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 300, maxWidth: 350),
                      child: ElevatedButton(
                          onPressed: (() {
                            MaterialApp(
                              title: 'Named Routes',
                              // Start the app with the "/" named route. In this case, the app starts
                              // on the FirstScreen widget.
                              initialRoute: '/',
                              routes: {
                                '/': (context) => const PageHomePage(),
                                // When navigating to the "/" route, build the FirstScreen widget.
                                '/userCommentView': (context) =>
                                    userCommentView(bank: widget.bank),
                                // '/linearBars':
                                //     (context) =>
                                //         linearBars(
                                //             banks: banks,
                                //             index: index
                                //             )
                                // When navigating to the "/second" route, build the SecondScreen widget.
                              },
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      userCommentView(bank: widget.bank)),
                            );
                          }),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.all(12),
                            backgroundColor: userRole == 'superAdmin'
                                ? Color.fromARGB(255, 223, 116, 116)
                                : const Color.fromARGB(255, 153, 116, 223),
                          ),
                          child: const Text("Quiero dejar mi opinión",
                              style: TextStyle(fontSize: 16)))))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: Container(
                  margin: const EdgeInsets.only(right: 15, left: 15),
                  height: 1,
                  width: screenWidth - 30,
                  color: const Color.fromARGB(255, 190, 190, 190),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 1),
            child: Column(
                children: List.generate(
                    widget.bank["reviews"].length,
                    (i) => InkWell(
                        onLongPress: () {
                          if (userRole == 'superAdmin') {
                            _showAlertDialog(widget.bank["reviews"]
                                .elementAt(i)["id"]
                                .toString());
                          }
                        },
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 213, 213, 213),
                                    )),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.only(
                                                left: 14, top: 10, bottom: 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 56, maxWidth: 66),
                                            child: Column(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                Icon(
                                                  Icons.account_circle,
                                                  size: 48,
                                                )
                                              ],
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // ignore: prefer_const_literals_to_create_immutables

                                                child: Text(
                                                    widget.bank["reviews"][i]
                                                        ["user"]["username"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.start),
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        StatmentRatingsUser(
                                                            rating: widget
                                                                .bank["reviews"]
                                                                    [i][
                                                                    "reviewRating"]
                                                                .toDouble())
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "         (${Jiffy(widget.bank["reviews"][i]["dateCreated"], "yyyy-MM-dd'T'HH:mm:ss").fromNow()})",
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        127,
                                                                        127,
                                                                        127)))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 2),
                                          child: Column(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              // ignore: prefer_const_literals_to_create_immutables
                                              Row(
                                                children: const [Text("")],
                                              ),
                                              //CAMBIAR!! HAY QUE CREAR COMPONENTE PARA LAS RATINGS PUESTAS POR EL USER
                                              Row(
                                                // ignore: prefer_const_literals_to_create_immutables

                                                children: [],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 18, left: 20, right: 15),
                                      child: Row(children: [
                                        SizedBox(
                                          width: 320,
                                          child: Text(
                                              widget.bank["reviews"][i]
                                                      ["review"]
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.left),
                                        )
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 14,
                                          top: 8,
                                          left: 15,
                                          right: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (jwt != '') {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                int foundIndex =
                                                    userFavoriteComments
                                                        .indexOf(widget
                                                            .bank["reviews"]
                                                            .elementAt(
                                                                i)["id"]);

                                                setState(() {
                                                  if (foundIndex != -1) {
                                                    userFavoriteComments
                                                        .removeAt(foundIndex);
                                                  } else {
                                                    userFavoriteComments.add(
                                                        widget.bank["reviews"]
                                                            .elementAt(
                                                                i)["id"]);
                                                  }

                                                  foundIndex =
                                                      userFavoriteComments
                                                          .indexOf(widget
                                                              .bank["reviews"]
                                                              .elementAt(
                                                                  i)["id"]);
                                                });

                                                print("userFavoriteComments");
                                                print(userFavoriteComments);

                                                jwt = prefs.getString("jwt");
                                                var getFavoritesComments =
                                                    Uri.parse(
                                                        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/reviews/like/review/' +
                                                            widget
                                                                .bank["reviews"]
                                                                .elementAt(
                                                                    i)["id"]
                                                                .toString());

                                                var response = await http.put(
                                                    getFavoritesComments,
                                                    headers: {
                                                      "Authorization": '$jwt'
                                                    });
                                                var finalResponse =
                                                    json.decode(response.body);

                                                setState(() {
                                                  widget.bank["reviews"]
                                                          .elementAt(
                                                              i)["likes"] =
                                                      finalResponse[
                                                          "numberOfLikesInReview"];
                                                });

                                                if (finalResponse["status"] ==
                                                    401) {
                                                  setState(() {
                                                    if (foundIndex != -1)
                                                      userFavoriteComments
                                                          .removeAt(foundIndex);
                                                  });
                                                }
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(),
                                                  child: Row(
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      !userFavoriteComments.contains(widget.bank["reviews"].elementAt(i)["id"])
                                                          ? Icon(Icons.favorite_border_rounded,
                                                              color: jwt != null &&
                                                                      jwt != ''
                                                                  ? Color.fromARGB(
                                                                      255, 153, 116, 223)
                                                                  : Color.fromARGB(
                                                                      255,
                                                                      116,
                                                                      108,
                                                                      130))
                                                          : Icon(Icons.favorite,
                                                              color: jwt != null &&
                                                                      jwt != ''
                                                                  ? Color.fromARGB(
                                                                      255, 153, 116, 223)
                                                                  : Color.fromARGB(
                                                                      255,
                                                                      127,
                                                                      109,
                                                                      161)),
                                                      Text(
                                                          widget.bank["reviews"]
                                                              .elementAt(
                                                                  i)["likes"]
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              height: 1,
                              width: 348,
                              // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
                              decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    // ignore: prefer_const_constructors
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 1.0,
                                        offset: const Offset(0.0, 0.55))
                                  ],
                                  color:
                                      const Color.fromARGB(255, 185, 185, 185)),
                            )
                          ],
                        )))),
          )
        ]),
      ),
    );
  }

  void _showAlertDialog(var id) {
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
                    "¿Deseas eliminar este comentario?",
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
                                  Color.fromARGB(255, 224, 66, 66)),
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var jwt = prefs.getString('jwt');

                            var deleteNew = Uri.parse(
                                'https://bankopinion-backend-development-3vucy.ondigitalocean.app/reviews/' +
                                    id);
                            final response =
                                await http.delete(deleteNew, headers: {
                              "Authorization": '$jwt',
                            });
                            Navigator.pop(context);

                            print(response.statusCode);
                            // setState(() {
                            //   news = jsonDecode(response.body);
                            // });
                          },
                          child: Text(
                            "Eliminar comentario",
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
