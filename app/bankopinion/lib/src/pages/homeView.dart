import 'dart:async';
import 'dart:convert';
import 'package:bankopinion/src/Reusable%20Components/bottomBar.dart';
import 'package:bankopinion/src/Reusable%20Components/ratingStarsBranch.dart';
import 'package:bankopinion/src/authServices/refreshToken.dart';
import 'package:bankopinion/src/pages/allReviewsView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
// import 'package:flutter_google_places_web/flutter_google_places_web.dart';

// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:google_api_headers/google_api_headers.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/favoritesService.dart';

class PageHomePage extends StatefulWidget {
  const PageHomePage({super.key});

  @override
  State<PageHomePage> createState() => _StateHomePage();
}

class _StateHomePage extends State<PageHomePage> {
  FavoritesService? favoritesService;
  String? jwt;
  String? userRole;

  List<dynamic>? favoriteBranch;
  List<dynamic>? favorited;

  //SEARCHBAR
  List bankList = [];
  List filteredList = [];
  var favorite = false;

  @override
  void initState() {
    super.initState();
    filteredList = bankList;
    Jiffy.locale('es');
    Jiffy().yMMMMEEEEdjm;
    getUserProfile();

    if (jwt != null) {
      var refresh = AuthService();
      refresh.refreshToken();
    }
    _getJWT();
    fetchData();
    _controller = TextEditingController();
  }

  void filter(String inputString) {
    filteredList =
        bankList.where((i) => i.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  Future<void> _getJWT() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwt = prefs.getString('jwt');
      userRole = prefs.getString('userRole');
    });
  }
  // Future<void> _getFavoriteBranch() async {
  //   final prefs = await SharedPreferences.getInstance();
  //        favoritesService?.;

  //   setState(() {
  //     favoriteBranch = prefs.getStringList('favoriteBranches');
  //   });
  // }

  late TextEditingController _controller;
  GoogleMapController? mapController; //controller for Google map

  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = const LatLng(39.4697500, -0.3773900);
  static const LatLng _center = LatLng(45.343434, -122.545454);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  var banks = [];
  var banksFound = [];
  var selectedBank = -1;
  late List<dynamic> userBranchesFavorites = [];

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
          print(userBranchesFavorites.length);
          var userId = responseData["userProfile"]["user_id"].toString();

          //GUARDAMOS EN SHAREDPREFERENCES LOS VALORES RECUPERADOS
          prefs.setString('user_id', userId);

          prefs.setStringList('favoriteBranches',
              userBranchesFavorites.map((e) => json.encode(e)).toList());
        });
      }
    }
  }

  Future<void> _onCameraMove(CameraPosition position) async {
    _lastMapPosition = position.target;
    if (position.zoom <= 10) return;

    var urlSucursales = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunkInDB/${_lastMapPosition.latitude},${_lastMapPosition.longitude}');

    final response = await http.get(urlSucursales);
    print(urlSucursales);

    setState(() {
      banks = jsonDecode(response.body);

      banks.forEach((element) async {
        if (element["value"]["location"] == null) return;

        LatLng showLocation = LatLng(element["value"]["location"]["lat"],
            element["value"]["location"]["lng"]);

        //location to show in map
        print(showLocation);
        markers.add(Marker(
            onTap: () => {sort(element["value"]["id"])},
            //add marker on google map
            markerId: MarkerId(showLocation.toString()),
            position: showLocation, //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: element["value"]["branchName"].toString(),
              snippet: element["value"]["address"],
            ),
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(size: Size(30, 30)),
                'assets/images/bankMarker.png')));
      });
    });
  }

  void sort(int id) {
    setState(() {
      var index = -1;
      for (var i = 0; i < banks.length; ++i)
        if (banks[i]["value"]["id"].toString() == id.toString()) index = i;

      var bank = banks[index];
      banks.removeAt(index);
      banks.insert(0, bank);
      selectedBank = id;
    });
  }

  Future<void> find(String address) async {
    final URL = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunkInDB/' +
            address);
    final response = await http.get(URL);

    // Hacer petición al backend con la dirección
    print(address);
  }

  Future<void> fetchData() async {
    var prueba = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunkInDB/${showLocation.latitude},${showLocation.longitude}');
    final response = await http.get(prueba);

    setState(() {
      banks = jsonDecode(response.body);

      banks.forEach((element) async {
        if (element["value"]["location"] == null) return;

        LatLng showLocation = LatLng(element["value"]["location"]["lat"],
            element["value"]["location"]["lng"]);

        //location to show in map
        markers.add(Marker(
            onTap: () => {sort(element["id"])},
            //add marker on google map
            markerId: MarkerId(showLocation.toString()),
            position: showLocation, //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: element["value"]["branchName"],
              snippet: element["value"]["address"],
            ),
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(size: Size(30, 30)),
                'assets/images/bankMarker.png')));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isBankSelected(index) {
    return selectedBank.toString() == banks.elementAt(index)["id"].toString();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomBar(),
      body: kIsWeb
          ?   Center(
              child: 
              SingleChildScrollView(
                          child:
              Container(child: 
              
               Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: kIsWeb ? 500 : 400,
                      child: GoogleMap(
                        //Map widget from google_maps_flutter packages
                        zoomGesturesEnabled: true, //enable Zoom in, out on map
                        initialCameraPosition: CameraPosition(
                          //innital position in map
                          target: showLocation, //initial position
                          zoom: 13.5, //initial zoom level
                        ),
                        markers: markers, //markers to show on map
                        mapType: MapType.normal, //map type
                        onCameraMove: _onCameraMove,
                        onMapCreated: (controller) {
                          //method called when map is created
                          setState(() {
                            mapController = controller;
                          });
                        },
                      )),

                  Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 10),
                      child: Container(
                          width: 500,
                          padding: EdgeInsets.only(
                              top: 2, left: 8, right: 8, bottom: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 224, 224, 224)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(children: [
                            const Icon(
                              Icons.search,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                    controller: _controller,
                                    onTap: () async {
                                      var place = await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey:
                                              "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0",
                                          mode: Mode.overlay,
                                          //overlayBorderRadius: ,
                                          types: [],
                                          strictbounds: false,
                                          logo: const SizedBox.shrink(),
                                          language: "es",
                                          components: [
                                            Component(Component.country, 'es')
                                          ],
                                          //google_map_webservice package
                                          onError: (err) {
                                            // ignore: avoid_print
                                            print(err);
                                          });

                                      if (place != null) {
                                        setState(() {
                                          var location =
                                              place.description.toString();
                                        });

                                        //form google_maps_webservice package
                                        final plist = GoogleMapsPlaces(
                                          apiKey:
                                              "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0",
                                          apiHeaders:
                                              await const GoogleApiHeaders()
                                                  .getHeaders(),
                                          //from google_api_headers package
                                        );
                                        String placeid = place.placeId ?? "0";
                                        final detail = await plist
                                            .getDetailsByPlaceId(placeid);
                                        final geometry =
                                            detail.result.geometry!;
                                        final lat = geometry.location.lat;
                                        final lang = geometry.location.lng;
                                        var newlatlang = LatLng(lat, lang);

                                        //move map camera to selected place with animation
                                        mapController?.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: newlatlang,
                                                    zoom: 15)));
                                        mapController?.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: newlatlang,
                                                    zoom: 15)));
                                      }
                                    },
                                    onSubmitted: (value) => {},
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Filtra por ubicación"),
                                    onChanged: (text) {
                                      find(text.toLowerCase());
                                    }),
                              ),
                            ),
                            const Icon(Icons.location_searching_sharp)
                          ]))),

//LISTA DE UBICACIONES RESPECTO A MARCADORES DEL CHUNK

                  Expanded(
                      child: Wrap(
                    children: [
                      for (int index = 0; index < banks.length; index++)
                        SizedBox(
                            width: 520,
                            child: InkWell(
                                onTap: () {
                                  LatLng newlatlong = LatLng(
                                      banks.elementAt(index)["value"]
                                          ["location"]["lat"],
                                      banks.elementAt(index)["value"]
                                          ["location"]["lng"]);
                                  mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: newlatlong, zoom: 18)));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 5, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        //color: isBankSelected(index) ? Color.fromARGB(255, 215, 215, 215) : Colors.transparent,
                                        border: Border.all(
                                          width: 2,
                                          color: isBankSelected(index)
                                              ? const Color.fromARGB(
                                                  255, 0, 0, 0)
                                              : const Color.fromARGB(
                                                  255, 223, 223, 223),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 100,
                                    padding:
                                        const EdgeInsets.only(top: 0, left: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6, top: 8),
                                              child: banks[index]["value"]["branchName"].length >
                                                      22
                                                  ? Text(
                                                      banks[index]["value"]["branchName"].substring(0, 27) +
                                                          "...",
                                                      // ,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : Text(
                                                      banks[index]["value"]
                                                          ["branchName"],
                                                      // ,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(255, 0, 0, 0),
                                                          fontWeight: FontWeight.bold)),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 200),
                                                  child: Text(
                                                      banks.elementAt(
                                                              index)["value"]
                                                          ["address"],
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
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 200),
                                                  child: Text(
                                                      banks.elementAt(index)[
                                                                  "value"]
                                                              ["zipcode"] +
                                                          ", " +
                                                          banks.elementAt(
                                                                  index)[
                                                              "value"]["city"],
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6, bottom: 4),
                                                    child: Row(
                                                      children: [
                                                        StatmentRatings(
                                                            bank:
                                                                banks.elementAt(
                                                                        index)[
                                                                    "value"]),
                                                        Text(
                                                            "(" +
                                                                banks
                                                                    .elementAt(index)[
                                                                        "value"]
                                                                        [
                                                                        "branchRating"]
                                                                    .toString() +
                                                                ")",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      66,
                                                                      66,
                                                                      66),
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 3, left: 5),
                                                    child: SizedBox(
                                                        width: 47.0,
                                                        height: 47.0,
                                                        child:
                                                            jwt != null &&
                                                                    jwt != '' &&
                                                                    userRole !=
                                                                        'superAdmin'
                                                                ? ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final prefs =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      int foundIndex =
                                                                          userBranchesFavorites.indexOf(banks.elementAt(index)["value"]
                                                                              [
                                                                              "id"]);
                                                                      setState(
                                                                          () {
                                                                        if (foundIndex !=
                                                                            -1)
                                                                          userBranchesFavorites
                                                                              .removeAt(foundIndex);
                                                                        else
                                                                          userBranchesFavorites.add(banks.elementAt(index)["value"]
                                                                              [
                                                                              "id"]);

                                                                        foundIndex =
                                                                            userBranchesFavorites.indexOf(banks.elementAt(index)["value"]["id"]);
                                                                      });
                                                                      jwt = prefs
                                                                          .getString(
                                                                              'jwt');
                                                                      var favoriteBranch =
                                                                          Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/addFavoriteBranch/' +
                                                                              banks.elementAt(index)["value"]["id"].toString());
                                                                      var response = await http.put(
                                                                          favoriteBranch,
                                                                          headers: {
                                                                            'Authorization':
                                                                                '$jwt'
                                                                          });
                                                                      var finalResponse =
                                                                          json.decode(
                                                                              response.body);

                                                                      if (finalResponse[
                                                                              "status"] ==
                                                                          401) {
                                                                        setState(
                                                                            () {
                                                                          if (foundIndex !=
                                                                              -1)
                                                                            userBranchesFavorites.removeAt(foundIndex);
                                                                        });
                                                                        var refresh =
                                                                            AuthService();
                                                                        await refresh
                                                                            .refreshToken();
                                                                      }

                                                                      //await getUserProfile();
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      shape:
                                                                          const CircleBorder(),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5),
                                                                      backgroundColor: userRole ==
                                                                              'superAdmin'
                                                                          ? Color.fromARGB(
                                                                              255,
                                                                              223,
                                                                              116,
                                                                              116)
                                                                          : const Color.fromARGB(
                                                                              255,
                                                                              153,
                                                                              116,
                                                                              223),
                                                                    ),
                                                                    child: !userBranchesFavorites.contains(banks.elementAt(index)["value"]
                                                                            [
                                                                            "id"])
                                                                        ? const Icon(Icons
                                                                            .favorite_border_rounded)
                                                                        : const Icon(
                                                                            Icons.favorite))
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
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                                              bank: banks.elementAt(index)["value"],
                                                                            )),
                                                              );
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  const CircleBorder(),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              backgroundColor: userRole ==
                                                                      'superAdmin'
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          223,
                                                                          116,
                                                                          116)
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
                                                            ))))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))))
                    ],
                  ))
                ],
              ),
            )))
          : Column(
              children: [
                Container(
                    height: 300,
                    child: GoogleMap(
                      //Map widget from google_maps_flutter packages

                      zoomGesturesEnabled: true, //enable Zoom in, out on map
                      initialCameraPosition: CameraPosition(
                        //innital position in map
                        target: showLocation, //initial position
                        zoom: 13.5, //initial zoom level
                      ),
                      markers: markers, //markers to show on map
                      mapType: MapType.normal, //map type
                      onCameraMove: _onCameraMove,
                      onMapCreated: (GoogleMapController controller) {
                        //method called when map is created
                        setState(() {
                          mapController = controller;
                        });
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 10),
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 2, left: 8, right: 8, bottom: 2),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 224, 224, 224)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(children: [
                          const Icon(
                            Icons.search,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: TextField(
                                  controller: _controller,
                                  onTap: () async {
                                    var place = await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey:
                                            "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0",
                                        mode: Mode.overlay,
                                        //overlayBorderRadius: ,
                                        types: [],
                                        strictbounds: false,
                                        logo: const SizedBox.shrink(),
                                        language: "es",
                                        components: [
                                          Component(Component.country, 'es')
                                        ],
                                        //google_map_webservice package
                                        onError: (err) {
                                          // ignore: avoid_print
                                          print(err);
                                        });

                                    if (place != null) {
                                      setState(() {
                                        var location =
                                            place.description.toString();
                                      });

                                      //form google_maps_webservice package
                                      final plist = GoogleMapsPlaces(
                                        apiKey:
                                            "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0",
                                        apiHeaders:
                                            await const GoogleApiHeaders()
                                                .getHeaders(),
                                        //from google_api_headers package
                                      );
                                      String placeid = place.placeId ?? "0";
                                      final detail = await plist
                                          .getDetailsByPlaceId(placeid);
                                      final geometry = detail.result.geometry!;
                                      final lat = geometry.location.lat;
                                      final lang = geometry.location.lng;
                                      var newlatlang = LatLng(lat, lang);

                                      //move map camera to selected place with animation
                                      mapController?.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: newlatlang,
                                                  zoom: 15)));
                                      //  webController.animateCamera(
                                      //     CameraUpdate.newCameraPosition(
                                      //         CameraPosition(
                                      //             target: newlatlang, zoom: 15)));
                                    }
                                  },
                                  onSubmitted: (value) => {},
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Filtra por ubicación"),
                                  onChanged: (text) {
                                    find(text.toLowerCase());
                                  }),
                            ),
                          ),
                          const Icon(Icons.location_searching_sharp)
                        ]))),

//LISTA DE UBICACIONES RESPECTO A MARCADORES DEL CHUNK

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: banks.length,
                    itemBuilder: (context, index) {
                      // ignore: dead_code
                      return InkWell(
                          onTap: () {
                            LatLng newlatlong = LatLng(
                                banks.elementAt(index)["value"]["location"]
                                    ["lat"],
                                banks.elementAt(index)["value"]["location"]
                                    ["lng"]);
                            mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: newlatlong, zoom: 18)));
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 5, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  //color: isBankSelected(index) ? Color.fromARGB(255, 215, 215, 215) : Colors.transparent,
                                  border: Border.all(
                                    width: 2,
                                    color: isBankSelected(index)
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : const Color.fromARGB(
                                            255, 223, 223, 223),
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              height: 100,
                              padding: const EdgeInsets.only(top: 0, left: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 6, top: 8),
                                        child: banks[index]["value"]["branchName"]
                                                    .length >
                                                22
                                            ? Text(
                                                banks[index]["value"]
                                                            ["branchName"]
                                                        .substring(0, 27) +
                                                    "...",
                                                // ,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : Text(
                                                banks[index]["value"]
                                                    ["branchName"],
                                                // ,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Color.fromARGB(255, 0, 0, 0),
                                                    fontWeight: FontWeight.bold)),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 200),
                                            child: Text(
                                                banks.elementAt(index)["value"]
                                                    ["address"],
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
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 200),
                                            child: Text(
                                                banks.elementAt(index)["value"]
                                                        ["zipcode"] +
                                                    ", " +
                                                    banks.elementAt(
                                                        index)["value"]["city"],
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
                                                      bank: banks.elementAt(
                                                          index)["value"]),
                                                  Text(
                                                      "(" +
                                                          banks
                                                              .elementAt(index)[
                                                                  "value"][
                                                                  "branchRating"]
                                                              .toString() +
                                                          ")",
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
                                                            int foundIndex = userBranchesFavorites
                                                                .indexOf(banks
                                                                        .elementAt(
                                                                            index)[
                                                                    "value"]["id"]);
                                                            setState(() {
                                                              if (foundIndex !=
                                                                  -1)
                                                                userBranchesFavorites
                                                                    .removeAt(
                                                                        foundIndex);
                                                              else
                                                                userBranchesFavorites.add(
                                                                    banks.elementAt(
                                                                            index)["value"]
                                                                        ["id"]);

                                                              foundIndex = userBranchesFavorites
                                                                  .indexOf(banks
                                                                          .elementAt(
                                                                              index)[
                                                                      "value"]["id"]);
                                                            });
                                                            jwt =
                                                                prefs.getString(
                                                                    'jwt');
                                                            var favoriteBranch =
                                                                Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/addFavoriteBranch/' +
                                                                    banks
                                                                        .elementAt(index)[
                                                                            "value"]
                                                                            [
                                                                            "id"]
                                                                        .toString());
                                                            var response =
                                                                await http.put(
                                                                    favoriteBranch,
                                                                    headers: {
                                                                  'Authorization':
                                                                      '$jwt'
                                                                });
                                                            var finalResponse =
                                                                json.decode(
                                                                    response
                                                                        .body);

                                                            if (finalResponse[
                                                                    "status"] ==
                                                                401) {
                                                              setState(() {
                                                                if (foundIndex !=
                                                                    -1)
                                                                  userBranchesFavorites
                                                                      .removeAt(
                                                                          foundIndex);
                                                              });
                                                              var refresh =
                                                                  AuthService();
                                                              await refresh
                                                                  .refreshToken();
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
                                                                    .fromARGB(
                                                                        255,
                                                                        223,
                                                                        116,
                                                                        116)
                                                                : const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    153,
                                                                    116,
                                                                    223),
                                                          ),
                                                          child: !userBranchesFavorites
                                                                  .contains(banks
                                                                          .elementAt(
                                                                              index)["value"]
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
                                                                        bank: banks
                                                                            .elementAt(index)["value"],
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
                                                                    .fromARGB(
                                                                        255,
                                                                        223,
                                                                        116,
                                                                        116)
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
                                                      ))))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )));
                    },
                  ),
                )
              ],
            ),
    );
  }
}
