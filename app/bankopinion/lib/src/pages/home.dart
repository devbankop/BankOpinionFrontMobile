import 'dart:async';
import 'dart:convert';
import 'package:bankopinion/src/Reusable%20Components/ratingStars.dart';
import 'package:bankopinion/src/pages/allReviews.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageHomePage extends StatefulWidget {
  const PageHomePage({super.key});

  @override
  State<PageHomePage> createState() => _StateHomePage();
}

class _StateHomePage extends State<PageHomePage> {
//SEARCHBAR
  List bankList = [];
  List filteredList = [];
  var favorite = false;


  @override
  void initState() {
    super.initState();
    filteredList = bankList;

    fetchData();
    _controller = TextEditingController();
  }

  

  void filter(String inputString) {
    filteredList =
        bankList.where((i) => i.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  late TextEditingController _controller;
  GoogleMapController? mapController; //controller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(39.4697500, -0.3773900);
  static const LatLng _center = const LatLng(45.343434, -122.545454);
          final Set<Marker> _markers = {};
          LatLng _lastMapPosition = _center;
  var banks = [];
  var banksFound = [];
  var selectedBank = -1;


  Future<void> _onCameraMove(CameraPosition position) async {

    _lastMapPosition = position.target;
    if( position.zoom <= 10 ) return; 

    var urlSucursales = Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunk/' + _lastMapPosition.latitude.toString() + ',' + _lastMapPosition.longitude.toString());

     final response = await http.get(urlSucursales);
    print(urlSucursales);


    setState(() {
      banks = jsonDecode(response.body);

      banks.forEach((element) async {
        if (element["geometry"]["location"] == null) return;

        LatLng showLocation =
            LatLng(element["geometry"]["location"]["lat"], element["geometry"]["location"]["lng"]);

        //location to show in map
        print(showLocation);
        markers.add(Marker(
          onTap: () => {sort(element["place_id"])},
          //add marker on google map
          markerId: MarkerId(showLocation.toString()),
          position: showLocation, //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: element["name"].toString(),
            snippet: element["vicinity"],
          ),
          icon: await BitmapDescriptor.fromAssetImage(
                      const ImageConfiguration(
                        size: Size(5, 5)),
                        'assets/images/bankMarker.png'
              )        ));
      });
    });
  }



  void sort(int id) {
    setState(() {
      var index = -1;
      for (var i = 0; i < banks.length; ++i)
        if (banks[i]["place_id"].toString() == id.toString()) index = i;

      var bank = banks[index];
      banks.removeAt(index);
      banks.insert(0, bank);
      selectedBank = id;
    });
  }

  Future<void> find( String address ) async 
  {
    final URL = Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunk/' + address);
    final response = await http.get(URL);

    // Hacer petición al backend con la dirección
    print(address);
  }

  Future<void> fetchData() async {
    var prueba = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/branches/branchesOfChunk/${showLocation.latitude},${showLocation.longitude}');
    final response = await http.get(prueba);

   setState(() {
      banks = jsonDecode(response.body);

      banks.forEach((element) async {
        if (element["geometry"]["location"] == null) return;

        LatLng showLocation =
            LatLng(element["geometry"]["location"]["lat"], element["geometry"]["location"]["lng"]);

        //location to show in map
        markers.add(Marker(
          onTap: () => {sort(element["place_id"])},
          //add marker on google map
          markerId: MarkerId(showLocation.toString()),
          position: showLocation, //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: element["name"],
            snippet: element["vicinity"],
          ),
          icon: await BitmapDescriptor.fromAssetImage(
                      const ImageConfiguration(
                        size: Size(5, 5)),
                        'assets/images/bankMarker.png'
              )
          //Icon for Marker
        ));
      });
    });
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isBankSelected(index) {
    return selectedBank.toString() == banks.elementAt(index)["place_id"].toString();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    //ROUTES
                MaterialApp(
                  title: 'Named Routes Demo',
                  // Start the app with the "/" named route. In this case, the app starts
                  // on the FirstScreen widget.
                  initialRoute: '/',
                  routes: {
                    '/': (context) => const PageHomePage(),
                    // When navigating to the "/" route, build the FirstScreen widget.
                    '/allReviews': (context) => allReviews(),
                    // When navigating to the "/second" route, build the SecondScreen widget.
                   
                  },
            );



    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
              height: 300,
              child: GoogleMap(

                
                //Map widget from google_maps_flutter package

                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: showLocation, //initial position
                  zoom: 12.0, //initial zoom level
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
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: Container(
                  padding:
                      EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 224, 224, 224)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(children: [
                    const Icon(
                      Icons.search,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(

                          
                          controller: _controller,
                          onSubmitted: (value) => {},
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Filtra por ubicación"),
                        
                          onChanged: (text) {
                              find( text.toLowerCase() );                             
                             }

                        ),
                      ),
                            
                    ),
                    const Icon(Icons.location_searching_sharp)
                  ]))),



    // Expanded(
    //         child: ListView.builder(
    //           padding: const EdgeInsets.symmetric(vertical: 10),
    //           itemCount: banksFound.length,
    //           itemBuilder: (context, index) {
    //             return Container(
    //                 margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
    //                 decoration: BoxDecoration(
    //                     //color: isBankSelected(index) ? Color.fromARGB(255, 215, 215, 215) : Colors.transparent,
    //                     border: Border.all(
    //                       width: 2,
    //                       color: isBankSelected(index)
    //                           ? Color.fromARGB(255, 0, 0, 0)
    //                           : Color.fromARGB(255, 223, 223, 223),
    //                     ),
    //                     borderRadius: BorderRadius.circular(12)),
    //                 height: 100,
    //                 padding: const EdgeInsets.only(top: 12, left: 12),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         Padding(
    //                           padding: EdgeInsets.only(bottom: 6),
    //                           child: Text(
    //                               banksFound.elementAt(index)["name"],
    //                               textAlign: TextAlign.left,
    //                               style: const TextStyle(
    //                                   fontSize: 18,
    //                                   color: Color.fromARGB(255, 0, 0, 0),
    //                                   fontWeight: FontWeight.bold)),
    //                         ),
    //                         Text(
    //                               banksFound.elementAt(index)["vicinity"],
    //                               textAlign: TextAlign.left,
    //                               style: const TextStyle(
    //                                 fontSize: 12,
    //                                 color: Color.fromARGB(255, 0, 0, 0),
    //                               )),
    //                         StatmentRatings()
    //                       ],
    //                     ),
    //                     Row(
    //                       children: [


    //                         //BOTÓN FAVORITOS
    //                         Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Container(
    //                                 margin: const EdgeInsets.only(right: 3, left: 5),

    //                             child: SizedBox(
    //                                 width: 47.0,
    //                                 height: 47.0,
    //                             child: ElevatedButton(
    //                             onPressed: (){},
    //                              style: ElevatedButton.styleFrom(
    //                               shape: CircleBorder(),
    //                               padding: EdgeInsets.all(5),

                                  
    //                               backgroundColor: Color.fromARGB(255, 153, 116, 223),
    //                             ),
    //                             child: 
    //                                    favorite == false 
    //                                    ? Icon(Icons.favorite_border_rounded) 
    //                                    : Icon(Icons.favorite)
    //                             )))
    //                           ],
                             
    //                         ),



    //                         //COLUMNA BOTÓN allReviews
    //                         Column(
                              
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Container(
    //                                 margin: const EdgeInsets.only(right: 8, left: 3),

    //                             child: SizedBox(
    //                                 width: 47.0,
    //                                 height: 47.0,
    //                             child: ElevatedButton(
    //                             onPressed: (){
    //                               Navigator.push(
    //                                             context,
    //                                             MaterialPageRoute(builder: (context) =>  allReviews()),
    //                                           );
    //                             },
    //                              style: ElevatedButton.styleFrom(
    //                               shape: CircleBorder(),
    //                               padding: EdgeInsets.all(5),

                                  
    //                               backgroundColor: Color.fromARGB(255, 153, 116, 223),
    //                             ),
    //                             child: 
    //                             const Icon(Icons.edit,
    //                                   //color: Color.fromRGBO(255, 255, 255, 255)
    //                                   )
    //                             )))
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 )
    //               );
    //           },
    //         ),
    // ),







//LISTA DE UBICACIONES RESPECTO A MARCADORES DEL CHUNK


          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: banks.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
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

                            Padding(
                              padding: const EdgeInsets.only(bottom: 6, top: 8),
                              child: Text(
                                
                                  banks.elementAt(index)["name"],
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold)),
                            ),
                              
                              Container(
                                  constraints: const BoxConstraints(maxWidth: 200),

                              child: Text(                               
                              banks.elementAt(index)["vicinity"],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 11,
                                  
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                              ),
                              
                            
                            Row(
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6, bottom: 4), 
                                  child: StatmentRatings(),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 6, bottom: 4), 
                                  child: Text("()", 
                                        style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 66, 66, 66),
                                )),
                                )
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
                                    margin: const EdgeInsets.only(right: 3, left: 5),

                                child: SizedBox(
                                    width: 47.0,
                                    height: 47.0,
                                child: ElevatedButton(
                                onPressed: (){},
                                 style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),

                                  
                                  backgroundColor: Color.fromARGB(255, 153, 116, 223),
                                ),
                                child: 
                                       favorite == false 
                                       ? Icon(Icons.favorite_border_rounded) 
                                       : Icon(Icons.favorite)
                                )))
                              ],
                             
                            ),



                            //COLUMNA BOTÓN allReviews
                            Column(
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 8, left: 3),

                                child: SizedBox(
                                    width: 47.0,
                                    height: 47.0,
                                child: ElevatedButton(
                                onPressed: (){
                                  Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>  allReviews()),
                                              );
                                },
                                 style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),

                                  
                                  backgroundColor: Color.fromARGB(255, 153, 116, 223),
                                ),
                                child: 
                                const Icon(Icons.edit,
                                      //color: Color.fromRGBO(255, 255, 255, 255)
                                      )
                                )))
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}
