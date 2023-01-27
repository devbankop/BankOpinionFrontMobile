import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bankopinion/src/auth/signup1.dart';
import 'package:bankopinion/src/pages/homeView.dart';
import 'package:bankopinion/src/pages/news.dart';
import 'package:bankopinion/src/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable Components/bottomBar.dart';
import '../auth/loginView.dart';

class addNew extends StatefulWidget {
  const addNew({super.key});

  @override
  State<addNew> createState() => _addNewState();
}

class _addNewState extends State<addNew> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _urlcontroller = TextEditingController();
  TextEditingController _imagecontroller = TextEditingController();
  TextEditingController _sourcecontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _desccontroller = TextEditingController();

  
NewsView newsView = NewsView();




  bool required = true;
  String? jwt;
  String? refresh_token;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _getRole();
  }

  Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole');
      jwt = prefs.getString('jwt');
    });
  }

  var prefs;
  
 String title = '';
 var url = '';
 var image;
 String publishDate = '';
 String publishTime = '';
 String description = '';
 String source = '';


  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }

  Future<void> sendNew() async {
    var body = jsonEncode({
      "title": title,
      "url": url,
      "image": image,
      "publishDate": publishDate,
            "publishTime": publishTime,

      "description": description,
      "source": source
    });

    var responseNews = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/news/');
    final response = await http.post(responseNews,
        body: body, 
        headers: {
          "Authorization": '$jwt',
          "Content-Type": "application/json"
          });

    // var addNews = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomBar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: userRole == 'superAdmin'
            ? SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Column(
                      children: [
                        Padding(
              padding: EdgeInsets.only(left: 0, bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.only(),
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
                              color: Color.fromARGB(255, 208, 0, 0),
                              size: 40,
                            )),
                      )),
                ],
              )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("NUEVA NOTICIA",
                          style: TextStyle(
                                fontSize: 26,
                                color: Color.fromARGB(255, 208, 0, 0),
                                fontWeight: FontWeight.bold))
                        ]),
                

//TÍTULO
                 Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                     
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Título",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                Text("*REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold)),
                               
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _titlecontroller,
                      onChanged: (String value) {
                        setState(() {                 
                            title = value;    
                  
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'La banca regala casas expropiadas',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),

//URL
                 Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Enlace",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                 Text("*REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      onChanged: (var value) {
                        setState(() {                 
                            url = value;                      
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'www.televisionredonda.com',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),



//IMAGEN
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Imagen",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                 Text("*NOT REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 115, 0, 0),
                                fontWeight: FontWeight.bold)),
                                
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _imagecontroller,
                      onChanged: (var value) {
                        setState(() {                 
                            image = value;                      
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'Enlace de la imagen',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),


//PUBLISHDATE
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Fecha de publicación",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                 Text("*REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _datecontroller,
                      onChanged: (String value) {
                        setState(() {                 
                            publishDate = value;                      
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'Escribir con formato yy-mm-dd',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),

//PUBLISHTIME
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Hora de publicación",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                 Text("*REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      onChanged: (String value) {
                        setState(() {                 
                            publishTime = value;                      
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'Escribir con formato hh-mm-ss',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),




                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Descripción",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                 Text("*NOT REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 115, 0, 0),
                                fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _desccontroller,
                      onChanged: (String value) {
                        setState(() {                 
                            description = value;                      
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'La banca regala casas expropiadas',
                      ),
                      maxLines: 10,
                      minLines: 1,
                    ),
                  ],
                ),


                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20),
                        // ignore: unnecessary_const
                        child: const Text("Source",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold))),
                                 Text("*REQUIRED*",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _sourcecontroller,
                      onChanged: (String value) {
                        setState(() {                 
                            source = value;                      
                        });
                      },
                     
                      decoration: InputDecoration(
                        hintText: 'elpais.com',
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ],
                ),

                required == false
                ? Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No se han rellenado los campos requeridos",
                    style: TextStyle(
                      color: Color.fromARGB(255, 244, 127, 54),
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ))
                  ],
                ))
                : Text("") ,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Padding(padding: EdgeInsets.only(top: 15, bottom:  25),
                   child: ElevatedButton(
                  onPressed: (() {
                    
                    
                      if(title != null && title != '' && url != null && url != '' && publishDate != null && publishDate != '' && publishTime != null && publishTime != '' && source != null && source != '')
                      {
                                                     newsView.createState().initState();

                        sendNew();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsView()));
                      } else
                      {
                        setState(() {
                              required = false;
                        });
                      }

                    
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    backgroundColor: Color.fromARGB(255, 205, 0, 75),
                  ),
                  child: Row(
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 28,
                                  
                                ),
                                Text(
                                  " Añadir nueva noticia",
                                  style: TextStyle(
                                      fontSize: 16),
                                )
                              ],
                            )
                )) 
                  ]
                )
                      ],
                    )))




            : null);
  }
}
