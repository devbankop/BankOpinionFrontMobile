import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'package:flutter_google_places_web/flutter_google_places_web.dart';

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
  String test = '';
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    getLocation();

    filteredList = bankList;
    Jiffy.locale('es');
    Jiffy().yMMMMEEEEdjm;
    getUserProfile();

    if (jwt != null) {
      var refresh = AuthService();
      refresh.refreshToken();
    }
    _getJWT();
    _controller = TextEditingController();
  }

  final GoogleMapsPlaces _placesApiClient =
      GoogleMapsPlaces(apiKey: "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0");

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
  }

  Timer? _timer;

  void _startTimer() {
    _timer
        ?.cancel(); // Cancela el temporizador existente antes de iniciar uno nuevo.
    _timer = Timer(const Duration(seconds: 2), () {
      fetchData();
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null as Timer?;
  }

  Set<Marker> markers = Set(); //markers for google map

  static LatLng _center = const LatLng(39.4697500, -0.3773900);

  late TextEditingController _controller;
  GoogleMapController? mapController; //controller for Google map

  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  var banks = [];
  var banksResponse = [];
  var banksFound = [];
  var selectedBank = -1;
  late List<dynamic> userBranchesFavorites = [];

  late Position position;
  var posLat;
  var posLong;
  var pos;

  void getLocation() async {
    bool locationEnabled = await Geolocator.isLocationServiceEnabled();

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        !locationEnabled) {
      setState(() {
        _center = const LatLng(39.4697500, -0.3773900);
        _lastMapPosition = const LatLng(39.4697500, -0.3773900);
      });
    } else {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy
            .bestForNavigation, // reducir la precisión para obtener la ubicación más rápidamente
      );
      setState(() {
        pos = LatLng(position.latitude, position.longitude);
        _center = LatLng(position.latitude, position.longitude);
        _lastMapPosition = LatLng(position.latitude, position.longitude);
      });

      CameraPosition currentPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14.5);

      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
    }

    await fetchData();
  }

  Future<void> _onCameraMove(CameraPosition position) async {
    _lastMapPosition = position.target;
    if (position.zoom <= 10) return;

    _cancelTimer();
    _startTimer();
  }

  Future<void> fetchData() async {
    // Define el URI de la solicitud http
    var prueba = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunkInDB/${_lastMapPosition.latitude},${_lastMapPosition.longitude}');

    // Realiza la solicitud http y espera la respuesta
    final response = await http.get(prueba);

    setState(() {
      banksResponse = jsonDecode(response.body);

      banksResponse.forEach((element) async {
        // if (element["value"]["location"] == null) return;
        if (element["status"] == "fulfilled") {
          banks.insert(0, element);

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
                  Platform.isIOS
                      ? 'assets/images/iosBankMarker.png'
                      : 'assets/images/bankMarker.png')));
        }
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
      body: Column(
        children: [
          Container(
              height: expanded == true ? 600 : 380,
              child: Stack(children: [
                GoogleMap(
                  //Map widget from google_maps_flutter packages
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition(
                    //innital position in map
                    target: pos ?? _center, //initial position
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
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                      // Handle button press
                    },
                    child: const Icon(
                      Icons.expand,
                      color: Color.fromARGB(255, 158, 54, 244),
                    ),
                  ),
                ),
              ])),
          Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() async {
                      var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0",
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          logo: const SizedBox.shrink(),
                          language: "es",
                          components: [Component(Component.country, 'es')],
                          onError: (err) {});

                      var location;
                      if (place != null) {
                        setState(() {
                          location = place;
                        });

                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: "AIzaSyATDrJ5JGDI5lYdILFfSPO2qI311W6mPw0",
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);

                        //move map camera to selected place with animation
                        mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: newlatlang, zoom: 15)));
                      }
                    }),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Color.fromARGB(46, 35, 0, 100),
                          width: .5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 8),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 93, 43, 184),
                          size: 30,
                        ),
                        Text(
                          " Búsqueda específica",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                  )
                ],
              )),

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
                          banks.elementAt(index)["value"]["location"]["lat"],
                          banks.elementAt(index)["value"]["location"]["lng"]);
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: newlatlong, zoom: 18)));
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
                                  : const Color.fromARGB(255, 223, 223, 223),
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        height: 100,
                        padding: const EdgeInsets.only(top: 0, left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 230.0,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 4, top: 8),
                                      child: Text(
                                          banks[index]["value"]["branchName"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold))),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 230.0,
                                      child: Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Text(
                                              banks[index]["value"]["address"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ))),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: Text(
                                          banks.elementAt(index)["value"]
                                                  ["zipcode"] +
                                              ", " +
                                              banks.elementAt(index)["value"]
                                                  ["city"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, bottom: 4),
                                        child: Row(
                                          children: [
                                            StatmentRatings(
                                                bank: banks
                                                    .elementAt(index)["value"]),
                                            Text(
                                                "(" +
                                                    banks
                                                        .elementAt(index)[
                                                            "value"]
                                                            ["branchRating"]
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            right: 3, left: 5),
                                        child: SizedBox(
                                            width: 47.0,
                                            height: 47.0,
                                            child: jwt != null &&
                                                    jwt != '' &&
                                                    userRole != 'superAdmin'
                                                ? ElevatedButton(
                                                    onPressed: () async {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      int foundIndex =
                                                          userBranchesFavorites
                                                              .indexOf(banks
                                                                      .elementAt(
                                                                          index)[
                                                                  "value"]["id"]);
                                                      setState(() {
                                                        if (foundIndex != -1)
                                                          userBranchesFavorites
                                                              .removeAt(
                                                                  foundIndex);
                                                        else
                                                          userBranchesFavorites
                                                              .add(banks.elementAt(
                                                                          index)[
                                                                      "value"]
                                                                  ["id"]);

                                                        foundIndex = userBranchesFavorites
                                                            .indexOf(banks
                                                                    .elementAt(
                                                                        index)[
                                                                "value"]["id"]);
                                                      });
                                                      jwt = prefs
                                                          .getString('jwt');
                                                      var favoriteBranch = Uri.parse(
                                                          'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/addFavoriteBranch/' +
                                                              banks
                                                                  .elementAt(index)[
                                                                      "value"]
                                                                      ["id"]
                                                                  .toString());
                                                      var response = await http
                                                          .put(
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
                                                        setState(() {
                                                          if (foundIndex != -1)
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      backgroundColor:
                                                          userRole ==
                                                                  'superAdmin'
                                                              ? Color.fromARGB(
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
                                                                        index)[
                                                                "value"]["id"])
                                                        ? const Icon(Icons
                                                            .favorite_border_rounded)
                                                        : const Icon(
                                                            Icons.favorite))
                                                : null))
                                  ],
                                ),

                                //COLUMNA BOTÓN allReviews
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                  bank: banks.elementAt(
                                                                          index)[
                                                                      "value"],
                                                                )),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  backgroundColor: userRole ==
                                                          'superAdmin'
                                                      ? Color.fromARGB(
                                                          255, 223, 116, 116)
                                                      : const Color.fromARGB(
                                                          255, 153, 116, 223),
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
