import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsView extends StatefulWidget {
  const PrefsView({Key? key}) : super(key: key);

  @override
  PrefsViewState createState() => PrefsViewState();
}


class PrefsViewState extends State<PrefsView> {
  late SharedPreferences _prefs;
  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLocationEnabled = _prefs.getBool('isLocationEnabled') ?? false;
    });
  }
void _toggleLocation(bool? value) async {
  if (value != null) {
    if (value == true) {
      
      _showAlertDialog();
      
    } else {
       
      PermissionStatus.denied;
      _deleteLocationPermissions();
      setState(() {
        _isLocationEnabled = false;
      });
    }
  }
}


void getLocation() async {
    bool locationEnabled = await Geolocator.isLocationServiceEnabled();

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  void _deleteLocationPermissions() async {

  await Permission.locationWhenInUse.serviceStatus.isDisabled;
  await _prefs.setBool('isLocationEnabled', false);
  setState(() {
    _isLocationEnabled = false;
  });
}

  Future<void> _getCurrentLocation() async {
// Solicita el permiso de ubicación
    var status = await Permission.location.request();

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      var permission = await Geolocator.checkPermission();
            permission = await Geolocator.requestPermission();

      status = PermissionStatus.granted;
      _prefs.setBool('isLocationEnabled', true);
    } else if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      var permission = await Geolocator.checkPermission();
            permission = await Geolocator.requestPermission();
      status = PermissionStatus.permanentlyDenied;
      _prefs.setBool('isLocationEnabled', false);
    }

    if (status != PermissionStatus.granted) {
      print('Permiso de ubicación denegado');
      _prefs.setBool('isLocationEnabled', false);
      return;
    }

// Obtiene la posición actual del usuario
    var position = await Geolocator.getCurrentPosition();
    print('Latitud: ${position.latitude}, Longitud: ${position.longitude}');
  }

  void getCurrentLocation() async {
    // Obtiene la posición actual del usuario
    var position = await Geolocator.getCurrentPosition();
    print('Latitud: ${position.latitude}, Longitud: ${position.longitude}');
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: 
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 70.0,
                          height: 70.0,
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
                            )),
                      )),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("PREFERENCIAS",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 55, 11, 137)
                                    )),
                ],
              ),
            Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: InkWell(
                          onTap: () {
                            openAppSettings();
                              //Geolocator.openLocationSettings();
                          },
                          child: Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),

                                color: Color.fromARGB(10, 55, 11, 137),
                                border: Border.all(
                                  color: Color.fromARGB(67, 55, 11, 137),
                                  width: .6,
                                ),
                              ),
                              child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                       Icon(Icons.location_on,
                                  color: Color.fromARGB(168, 55, 11, 137),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text("Gestionar permisos de ubicación",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 43, 11, 104)
                                    ))),
                                    ],
                                  ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(Icons.arrow_right,
                                        color: Color.fromARGB(109, 55, 11, 137),),
                                      ],
                                    )
                                ],
                              )),
                              ),
                        )),
           
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(){
  // Muestra un diálogo para pedir el consentimiento del usuario
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Consentimiento'),
        content: const Text('Permitir que la aplicación acceda a la ubicación aproximada del dispositivo.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
              _prefs.setBool('isLocationEnabled', false);
              setState(() {
                _isLocationEnabled = false;
              });
            },
          ),
          TextButton(
            child: const Text('Permitir'),
            onPressed:() async {

              ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Permisos de localización activados'),
    duration: Duration(seconds: 2), // Tiempo que permanece visible
  ),
);
                    await Permission.locationWhenInUse.serviceStatus.isEnabled;

              _prefs.setBool('isLocationEnabled', true);
              //               _toggleLocation(true);

              Navigator.of(context).pop();
               _handleLocationPermission();
            }, 
          ),
        ],
      );
    },
  );
}

void _handleLocationPermission() async {

  // Solicita el permiso de ubicación
  var permissionStatus = await Permission.location.request();
  if (permissionStatus != PermissionStatus.granted) {
    print('Permiso de ubicación denegado');
    _prefs.setBool('isLocationEnabled', false);
    setState(() {
      _isLocationEnabled = false;
      _toggleLocation(_isLocationEnabled);
        Navigator.of(context).pop();

    });
    return;
  } else {
    _prefs.setBool('isLocationEnabled', true);
    setState(() {
      _isLocationEnabled = true;
      _toggleLocation(_isLocationEnabled);
        Navigator.of(context).pop();

    });
  }
}

}
