import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Reusable Components/ratingStarsBranch.dart';
import 'allReviewsView.dart';


class topBranchesView extends StatefulWidget {
  const topBranchesView({Key? key}) : super(key: key);

  @override
  topBranchesViewState createState() => topBranchesViewState();
}


class topBranchesViewState extends State<topBranchesView> {

  var top = [];
  String? jwt;
  String? userRole;
  late List<dynamic> userBranchesFavorites = [];


  getBestBranches() async{
     
          var bestBranches = Uri.parse(
              'https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/topBranches');

          var response = await http.get(bestBranches);

        print(response.statusCode);

          if (response.statusCode == 200) {
            setState(() {
              //RECUPERAMOS VALORES DE LA RESPUESTA DE LA PETICIÓN
               top = json.decode(response.body);
               print(top);
            });


          } else {
              print(response.statusCode);
          }

  }

    Future<void> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    jwt = prefs.getString("jwt");
    if (jwt != null && jwt != '') {
      var getFavorites = Uri.parse(
          'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/getUser');

      var response =
          await http.get(getFavorites, headers: {"Authorization": '$jwt'});

      if (response.statusCode == 200) {
        //RECUPERAMOS VALORES DE LA RESPUESTA DE LA PETICIÓN
        Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          userBranchesFavorites =
              responseData["userProfile"]["userBranchesFavorites"];
          var userId = responseData["userProfile"]["user_id"].toString();

          //GUARDAMOS EN SHAREDPREFERENCES LOS VALORES RECUPERADOS
          prefs.setString('user_id', userId);

          prefs.setStringList('favoriteBranches',
              userBranchesFavorites.map((e) => json.encode(e)).toList());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getBestBranches();
    getUserProfile();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: 
        Padding(
            padding: const EdgeInsets.only(top: 15, left: 2, right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 70.0,
                          height: 70.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center, // Agregado para centrar verticalmente

                        children: const [
                          SizedBox(
                                    width: 300.0,
                                    child: 
                          Text("MEJORES SUCURSALES",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 55, 11, 137)
                                    )))
                        
                        ],
                ),
               ),
              
               Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: top.length,
                    itemBuilder: (context, index) {
                      // ignore: dead_code
                      return InkWell(
                          onTap: () {
                            
                          },
                          child: 
                          Padding(padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                          child:   
                          SizedBox(child: 
                          Container(
                              padding: EdgeInsets.only(left: 14, bottom: 12, top: 12),
                              decoration: BoxDecoration(
                                  //color: istopelected(index) ? Color.fromARGB(255, 215, 215, 215) : Colors.transparent,
                                  border: Border.all(
                                    width: 2,
                                    color:  const Color.fromARGB(255, 223, 223, 223),
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child:
                              
                              Column(
                                children: [
                                top[index]["isTopBranch"] == true
                                      ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.emoji_events,
                                           color: Color.fromARGB(255, 203, 152, 0),),
                                          Text(" Top 1 de " + top[index]["branchMerit"] + '',
                                          style: TextStyle(
                                            color: Color.fromARGB(150, 0, 0, 0),
                                            fontStyle: FontStyle.italic
                                          ),),
                                          Icon(Icons.emoji_events,
                                          color: Color.fromARGB(255, 203, 152, 0),),
                                        ],
                                      )
                                      : SizedBox.shrink(),
                               Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                      SizedBox(
                                    width: 230.0,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 4, top: 8),
                                        child: Text(
                                            top[index]["branchName"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.bold))),
                                  ),
                                      Row(
                                        children: [
                                          SizedBox(
                                    width: 230.0,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            ),
                                        child: Text(
                                            top[index]["address"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ))),
                                  ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 200),
                                            child: Text(
                                                top.elementAt(index)
                                                        ["zipcode"] +
                                                    ", " +
                                                    top.elementAt(
                                                        index)["city"],
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                )),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6, bottom: 4),
                                              child: Row(
                                                children: [
                                                  StatmentRatings(
                                                      bank: top.elementAt(
                                                          index)),
                                                  Text(
                                                      "(${top.elementAt(index)["branchRating"]})",
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Color.fromARGB(
                                                            255, 66, 66, 66),
                                                      )),
                                                ],
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //BOTÓN FAVORITOS
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 3, left: 5),
                                              child: SizedBox(
                                                  width: 47.0,
                                                  height: 47.0,
                                                  child: jwt != null &&
                                                          jwt != '' &&
                                                          userRole !=
                                                              'superAdmin'
                                                      ? ElevatedButton(
                                                          onPressed: () async {
                                                            final prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            int foundIndex = userBranchesFavorites.indexOf(top.elementAt(index)["id"]);
                                                            setState(() {
                                                              if (foundIndex !=
                                                                  -1)
                                                                userBranchesFavorites
                                                                    .removeAt(
                                                                        foundIndex);
                                                              else
                                                                userBranchesFavorites.add(
                                                                    top.elementAt(
                                                                            index)
                                                                        ["id"]);

                                                              foundIndex = userBranchesFavorites.indexOf(top.elementAt(index)["id"]);
                                                            });
                                                            jwt =
                                                                prefs.getString(
                                                                    'jwt');
                                                            var favoriteBranch =
                                                                Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/addFavoriteBranch/' +
                                                                    top.elementAt(index)["id"].toString());
                                                            var response =
                                                                await http.put(
                                                                    favoriteBranch,
                                                                    headers: {
                                                                  'Authorization':
                                                                      '$jwt'
                                                                });
                                                            var finalResponse =json.decode(response.body);

                                                            if (finalResponse["status"] == 401) {
                                                              setState(() {
                                                                if (foundIndex != -1)userBranchesFavorites.removeAt(foundIndex);
                                                              });
                                                            
                                                            }

                                                            //await getUserProfile();
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                const CircleBorder(),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            backgroundColor: userRole ==
                                                                    'superAdmin'
                                                                ? Color
                                                                    .fromARGB( 255, 223, 116, 116)
                                                                : const Color
                                                                        .fromARGB( 255, 153, 116, 223),
                                                          ),
                                                          child: !userBranchesFavorites
                                                                  .contains(top
                                                                          .elementAt(
                                                                              index)
                                                                      ["id"])
                                                              ? const Icon(Icons
                                                                  .favorite_border_rounded)
                                                              : const Icon(Icons
                                                                  .favorite))
                                                      : null))
                                        ],
                                      ),

                                      //COLUMNA BOTÓN allReviews
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8, left: 3),
                                              child: SizedBox(
                                                  width: 47.0,
                                                  height: 47.0,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        //ROUTES

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      allReviews(
                                                                        bank: top.elementAt(index),
                                                                      )),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            const CircleBorder(),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        backgroundColor:
                                                            userRole ==
                                                                    'superAdmin'
                                                                ? Color
                                                                    .fromARGB(255, 223, 116, 116)
                                                                : const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    153,
                                                                    116,
                                                                    223),
                                                      ),
                                                      child: const Icon(
                                                        Icons.edit,
                                                        //color: Color.fromRGBO(255, 255, 255, 255)
                                                      ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      
                              ],)),
                          )));
  }))],
        ),
      ),
    );
  }
}
