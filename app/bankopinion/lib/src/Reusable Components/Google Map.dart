import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(39.4697500, -0.3773900);  
                            //location to show in map

  @override
  void initState() {
      markers.add(Marker( //add marker on google map
          markerId: MarkerId(showLocation.toString()),
          position: showLocation, //position of marker
          infoWindow: InfoWindow( //popup info 
            title: 'My Custom Title ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //you can add more markers here
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Google Map in Flutter"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
          body: GoogleMap( //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition( //innital position in map
                      target: showLocation, //initial position
                      zoom: 30.0, //initial zoom level
                    ),
                    markers: markers, //markers to show on map
                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      setState(() {
                        mapController = controller; 
                      });
                    },
              ),
       );
  }
}