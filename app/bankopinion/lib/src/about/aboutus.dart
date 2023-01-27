import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class aboutUsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: 
        
            SingleChildScrollView(
              child:
        Padding(
            padding: EdgeInsets.all(20),
                child: Column(
              children: [
                Padding(
              padding: const EdgeInsets.only(bottom: 15),
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
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 153, 116, 223),
                            )),
                      )),
                ],
              )),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 20),
                      child: Text("Sobre nosotros",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ))),
                      Text("BankOpinion nace del desapego a la manera de actuar que están adoptando las entidades bancarias progresivamente en sus sucursales sin tener en cuenta la situación de sus clientes y empleados, y es por eso que nace BankOpinion, nace con la intención de poder dar al pueblo la herramienta para poder opinar del trato recibido en su sucursal, para poder tener de manera centralizada un recurso que te permita ver también opiniones de otros clientes sobre otras sucursales a lo largo y ancho de España, pudiendo guardar como favorito aquellas con mejores calificaciones o incluso dando un “Me gusta” a aquellos comentarios más críticos. Y no sólo eso, también podrás estar completamente al día de todas las novedades que vayan surgiendo sobre el mundo financiero al instante, por lo que se convierte en una gran herramienta muy polivalente e informativa para el pueblo.")
                    ],
                  )
              ],
            ))));
  }
}
