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
                                  Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2),
                                      child: Text(
                                        "Gestionar permisos de ubicación",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 43, 11, 104)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(
                                      Icons.arrow_right,
                                      color: Color.fromARGB(109, 55, 11, 137),
                                    ),
                                  ],
                                ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
