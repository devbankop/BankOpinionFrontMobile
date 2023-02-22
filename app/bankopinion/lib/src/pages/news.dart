import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'dart:io';
import 'package:bankopinion/src/auth/signup1.dart';
import 'package:bankopinion/src/pages/homeView.dart';
import 'package:bankopinion/src/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable Components/bottomBar.dart';
import '../auth/loginView.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../authServices/refreshToken.dart';
import '../superAdminViews/addNew.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  String? userRole;

  Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole');
    });
  }

  final ScrollController _scrollController = ScrollController();

  String formattedDate = '';
  var news = [];
  var enlaceNew = '';
  bool _showWebView = false;
  String _selectedUrl = '';
  @override
  void initState() {
    fetchData();
    _getRole();
     var refresh = AuthService();
    refresh.refreshToken();
     
    super.initState();
  }

  Future<void> fetchData() async {
    var responseNews = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/news/0/10');
    final response = await http.get(responseNews);

    setState(() {
      news = jsonDecode(response.body);
    });
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
            color:    userRole == 'superAdmin'?Color.fromARGB(255, 223, 116, 116) : Color.fromARGB(241, 66, 26, 140),
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
                              backgroundColor:
                                  userRole == 'superAdmin'?Color.fromARGB(255, 223, 116, 116) : Color.fromARGB(255, 75, 6, 202),
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
                              backgroundColor:
                                  userRole == 'superAdmin'?Color.fromARGB(255, 223, 116, 116) : Color.fromARGB(255, 61, 15, 148),
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
                  : null),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
          Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: InkWell(
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
                                        color:
                                            Color.fromARGB(29, 154, 116, 223),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: .6, // ancho del borde
                                            color: Color.fromARGB(
                                                255, 154, 116, 223))),
                                    height:
                                        news.elementAt(index)['image'] == null
                                            ? 105
                                            : 230,
                                    width: double.infinity,
                                    child:SizedBox(
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
                                              Image.network(
                                                news.elementAt(index)['image'],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 125.0,
                                                //fit: BoxFit.cover,
                                              ),
                                             Padding(padding: EdgeInsets.only(bottom: 4),
                                             child: Column(
                                              children: [
                                                 Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    // color: Color.fromARGB(147, 255, 255, 255)
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Column(
                                                        
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                                  
                                                          children: [
                                                            Text(
                                                                news.elementAt(
                                                                        index)[
                                                                    "title"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ]))),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 6),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            news.elementAt(
                                                                    index)[
                                                                "publishDate"],
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      90,
                                                                      90,
                                                                      90),
                                                              fontSize: 12,
                                                            )),
                                                        Text("    ·    "),
                                                        Text(
                                                            news.elementAt(
                                                                    index)[
                                                                "source"],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      90,
                                                                      90,
                                                                      90),
                                                              fontSize: 12,
                                                            )),
                                                            Text("    ·    "),
                                                        Text(
                                                            news.elementAt(
                                                                    index)[
                                                                "publishTime"],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      90,
                                                                      90,
                                                                      90),
                                                              fontSize: 12,
                                                            ))
                                                      ]))
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
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        // color: Color.fromARGB(147, 255, 255, 255)
                                                      ),
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    news.elementAt(
                                                                            index)[
                                                                        "title"],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold))
                                                              ]))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                news.elementAt(
                                                                        index)[
                                                                    "publishDate"],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          90,
                                                                          90,
                                                                          90),
                                                                  fontSize: 12,
                                                                )),
                                                            Text("    ·    "),
                                                            Text(
                                                                news.elementAt(
                                                                        index)[
                                                                    "source"],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          90,
                                                                          90,
                                                                          90),
                                                                  fontSize: 12,
                                                                )),
                                                                Text("    ·    "),
                                                        Text(
                                                            news.elementAt(
                                                                    index)[
                                                                "publishTime"],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      90,
                                                                      90,
                                                                      90),
                                                              fontSize: 12,
                                                            )),
                                                          ]))
                                                ])))))));
                  }))
        ]));
  }
}
