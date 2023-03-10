import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable Components/bottomBar.dart';

// Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../superAdminViews/addNew.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  String? userRole;

 

  final ScrollController _scrollController = ScrollController();

  String formattedDate = '';
  var news = [];
  var enlaceNew = '';
  bool _showWebView = false;
  String _selectedUrl = '';
  
 Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      userRole = prefs.getString('userRole');
  }

  @override
  void initState() {
    _getRole();
    super.initState();
  }
  
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    var responseNews = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/news/0/50');
try {
    final response = await http.get(responseNews);
    setState(() {
      news = jsonDecode(response.body);
    });
  } catch (error) {
    print(error.toString());
  }
  }

  _launchURL() async {
    var url = enlaceNew;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomBar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 80,
            color: userRole == 'superAdmin'
                ? Color.fromARGB(255, 194, 65, 65)
                : Color.fromARGB(241, 66, 26, 140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "BankOpinion",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: const Text("News",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  )))
                        ]))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
              child: userRole == 'superAdmin'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("                "),
                        ElevatedButton(
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addNew()));
                            }),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 14),
                              backgroundColor: userRole == 'superAdmin'
                                  ? Color.fromARGB(255, 223, 116, 116)
                                  : Color.fromARGB(255, 75, 6, 202),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 28,
                                ),
                                Text(
                                  " Añadir noticia",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )),
                        ElevatedButton(
                            onPressed: (() {
                              fetchData();
                            }),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: userRole == 'superAdmin'
                                  ? Color.fromARGB(255, 223, 116, 116)
                                  : Color.fromARGB(255, 61, 15, 148),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.refresh,
                                  size: 22,
                                ),
                              ],
                            ))
                      ],
                    )
                  : 
                  Padding(padding: EdgeInsets.only(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                            onPressed: (() {
                              fetchData();
                            }),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: userRole == 'superAdmin'
                                  ? Color.fromARGB(255, 223, 116, 116)
                                  : Color.fromARGB(255, 81, 37, 163),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.refresh,
                                  size: 22,
                                ),
                              ],
                            ))
                    ]
                  ))
                  ),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: InkWell(
                  onTap: () {
                    _scrollController.animateTo(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 40, 0, 115)),
                      ),
                      Text("  Ver más recientes  ",
                          style: TextStyle(fontSize: 12)),
                      Container(
                        height: 1,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 40, 0, 115)),
                      )
                    ],
                  ))),

        kIsWeb
        ?
        Expanded(
              child: 
                   
                        SingleChildScrollView(
                          child: Wrap(
                          children: [
                             for (int index = 0; index < news.length; index++)
                            SizedBox(
                          width: 420,
                          child: InkWell(
                            
                            onTap: () async {
                              setState(() {
                                enlaceNew = news.elementAt(index)['url'];
                              });
                              _launchURL();
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                                child: Container(
                                  width: 10,

                                    decoration: BoxDecoration(
                                        color: news.elementAt(index)['image'] == null ? Colors.white :Color.fromARGB(29, 154, 116, 223),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: .6, // ancho del borde
                                            color: Color.fromARGB(
                                                255, 154, 116, 223))),
                                    height:
                                        news.elementAt(index)['image'] == null
                                            ? 125
                                            : MediaQuery.of(context).size.height > 620
                                            ? 320
                                            : 300,
                                    
                                    child: SizedBox(
                                        width: 10,
                                        height: 10,
                                        child:
                                            news.elementAt(index)['image'] !=
                                                    null
                                                ? Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [

                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: news.elementAt(index)['image'].toString(),
                                                width: double.infinity,
                                                height: 220,
                                                fit: BoxFit.cover,
                                                errorWidget: (BuildContext context, String url, dynamic error) {
                                                  print('Error al cargar la imagen: $error');
                                                  return const Center(child: Text('Error al cargar la imagen'));
                                                },
                                              ),
                                            ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      bottom:
                                                                          4),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        // color: Color.fromARGB(147, 255, 255, 255)
                                                                      ),
                                                                      child: Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                            Text(news.elementAt(index)["title"],
                                                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                                                          ]))),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              6),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(news.elementAt(index)["publishDate"],
                                                                                style: const TextStyle(
                                                                                  color: Color.fromARGB(255, 90, 90, 90),
                                                                                  fontSize: 12,
                                                                                )),
                                                                            Text("    ·    "),
                                                                            Text(news.elementAt(index)["source"],
                                                                                style: TextStyle(
                                                                                  color: Color.fromARGB(255, 90, 90, 90),
                                                                                  fontSize: 12,
                                                                                )),
                                                                            Text("    ·    "),
                                                                            Text(news.elementAt(index)["publishTime"],
                                                                                style: TextStyle(
                                                                                  color: Color.fromARGB(255, 90, 90, 90),
                                                                                  fontSize: 12,
                                                                                )),
                                                                              
                                                                          ])),
                                                                        
                                                                ],
                                                              ))
                                                        ]))
                                                : Padding(
                                                    padding: EdgeInsets.all(6),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                // color: Color.fromARGB(147, 255, 255, 255)
                                                              ),
                                                              child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            news.elementAt(index)[
                                                                                "title"],
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                                                      ]))),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 0),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        news.elementAt(index)[
                                                                            "publishDate"],
                                                                        style:
                                                                            const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              90,
                                                                              90),
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Text(
                                                                        "    ·    "),
                                                                    Text(
                                                                        news.elementAt(index)["source"].toString().length > 20
                                                                            ? news.elementAt(index)["source"].toString().substring(0, 18) +
                                                                                "..."
                                                                            : news.elementAt(index)["source"].toString(),
                                                                        style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              90,
                                                                              90),
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Text(
                                                                        "    ·    "),
                                                                    Text(
                                                                        news.elementAt(index)[
                                                                            "publishTime"],
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              90,
                                                                              90),
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    
                                                                  ])),
                                                                  
                                                        ]))))
                                                        )
                                                        )
                                                        )
                          ],
                        ))
                  
                  )

         : Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                            onLongPress: () {
                              if(userRole == 'superAdmin')
                              {
                                 _showAlertDialog(
                                  news.elementAt(index)["id"].toString());
                              }
                            },
                            onTap: () async {
                              setState(() {
                                enlaceNew = news.elementAt(index)['url'];
                              });
                              _launchURL();
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: userRole == 'superAdmin'
                                            ? Color.fromARGB(59, 223, 116, 116)
                                            : Color.fromARGB(29, 154, 116, 223),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: .6, // ancho del borde
                                            color: Color.fromARGB(
                                                255, 154, 116, 223))),
                                    height:
                                        news.elementAt(index)['image'] == null
                                            ? 105
                                            : 300,
                                    width: double.infinity,
                                    child: Expanded(
                                      child:
                                    SizedBox(
                                        height: double.infinity,
                                        child:
                                            news.elementAt(index)['image'] !=
                                                    null
                                                ? Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(15),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: news
                                                                  .elementAt(index)[
                                                                      'image']
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  bottom: 4),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  // color: Color.fromARGB(147, 255, 255, 255)
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        news.elementAt(
                                                                            index)['title'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 6),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      news.elementAt(
                                                                              index)[
                                                                          'publishDate'],
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            90,
                                                                            90,
                                                                            90),
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '    ·    '),
                                                                    Text(
                                                                      news.elementAt(
                                                                              index)[
                                                                          'source'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            90,
                                                                            90,
                                                                            90),
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '    ·    '),
                                                                    Text(
                                                                      news.elementAt(
                                                                              index)[
                                                                          'publishTime'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            90,
                                                                            90,
                                                                            90),
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                                : Padding(
                                                    padding: EdgeInsets.all(6),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                // color: Color.fromARGB(147, 255, 255, 255)
                                                              ),
                                                              child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            news.elementAt(index)[
                                                                                "title"],
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                                                      ]))),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 0),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        news.elementAt(index)[
                                                                            "publishDate"],
                                                                        style:
                                                                            const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              90,
                                                                              90),
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Text(
                                                                        "    ·    "),
                                                                    Text(
                                                                        news.elementAt(index)["source"].toString().length > 20
                                                                        ? news.elementAt(index)["source"].toString().substring(0, 18) + "..."
                                                                        : news.elementAt(index)["source"].toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              90,
                                                                              90),
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Text(
                                                                        "    ·    "),
                                                                    Text(
                                                                        news.elementAt(index)[
                                                                            "publishTime"],
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              90,
                                                                              90),
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                  ]))
                                                        ]))))))));
              }
                  ))
        ]));
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
                    "Deseas eliminar esta noticia?",
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
                                'https://bankopinion-backend-development-3vucy.ondigitalocean.app/news/' +
                                    id);
                            final response =
                                await http.delete(deleteNew, headers: {
                              "Authorization": '$jwt',
                            });
                            fetchData();
                            Navigator.pop(context);

                            print(response.statusCode);
                            // setState(() {
                            //   news = jsonDecode(response.body);
                            // });
                          },
                          child: Text(
                            "Eliminar",
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
