import 'dart:convert';
import 'dart:io';

import 'package:bankopinion/src/pages/allProfessionalsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class requestProfessionalView extends StatefulWidget {
  @override
  requestProfessionalViewState createState() => requestProfessionalViewState();
}

class requestProfessionalViewState extends State<requestProfessionalView> {
  late SharedPreferences _prefs;
  bool _isLocationEnabled = false;
  bool err = false;
  bool err1 = false;

  List<String> _options = ['€ (Económico)', '€€ (Moderado)', '€€€ (Alto)'];
  String? selectedAmount;
  String? _selectedAmount;


  String? selectedCiudad;

  List<String> options = ['Abogados', 'Juristas', 'Gestores', 'Notarios'];
  List<String> ciudades = [
    'A Coruña',
    'Álava',
    'Albacete',
    'Alicante',
    'Almería',
    'Asturias',
    'Ávila',
    'Badajoz',
    'Barcelona',
    'Burgos',
    'Cáceres',
    'Cádiz',
    'Cantabria',
    'Castellón',
    'Ciudad Real',
    'Córdoba',
    'Cuenca',
    'Gerona',
    'Granada',
    'Guadalajara',
    'Guipúzcoa',
    'Huelva',
    'Huesca',
    'Islas Baleares',
    'Jaén',
    'La Rioja',
    'Las Palmas',
    'León',
    'Lérida',
    'Lugo',
    'Madrid',
    'Málaga',
    'Murcia',
    'Navarra',
    'Orense',
    'Palencia',
    'Pontevedra',
    'Salamanca',
    'Santa Cruz de Tenerife',
    'Segovia',
    'Sevilla',
    'Soria',
    'Tarragona',
    'Teruel',
    'Toledo',
    'Valencia',
    'Valladolid',
    'Vizcaya',
    'Zamora',
    'Zaragoza',
  ];
  String? selectedOption;

  final typeController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  final webController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  final emailController = TextEditingController();
  final chatController = TextEditingController();
  final scheduleController = TextEditingController();

  final imageController = TextEditingController();
  final amountController = TextEditingController();
  final cityController = TextEditingController();

  final cifController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  
  PickedFile? imageFile;







Future<void> newProfessionalRequest() async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://bankopinion-backend-development-3vucy.ondigitalocean.app/professionals/'),
    );

    request.fields['type'] = selectedOption!;
    request.fields['title'] = titleController.text;
    // Agregar otros campos de texto

    if (imageFile != null) {
      final mimeTypeData = lookupMimeType(imageFile!.path);
      final file = await http.MultipartFile.fromPath(
        'image',
        imageFile!.path,
        contentType: MediaType.parse(mimeTypeData!),
      );
      request.files.add(file);
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      _showAlertDialog();
      err1 = false;
      // Limpiar los controladores
    } else {
      setState(() {
        err1 = true;
      });
    }
  } catch (error) {
    print('Error: $error');
    // Aquí puedes agregar más manejo de errores o mostrar información adicional sobre el error al usuario
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 153, 116, 223),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SOLICITUD PROFESIONAL",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 11, 137)),
                ),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: const [
                        Text(
                            "A fin de que nuestro equipo en BankOpinion pueda revisar su solicitud de manera eficiente, le recordamos que es necesario completar todos los campos requeridos de manera precisa y exhaustiva.",
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(175, 55, 11, 137)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Razón social:",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(220, 42, 7, 107)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: titleController,
                            onChanged: (String value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'Razón social de la sociedad',
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "CIF:",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(220, 42, 7, 107)),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.info,
                                    size: 20,
                                    color: Color.fromARGB(255, 153, 116, 223)),
                                onSelected: (String result) {
                                  // ignore: avoid_print
                                  print(result);
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Info',
                                    child: Text(
                                        'Necesitaremos el CIF para verificar que se trata de una sociedad real.'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: TextField(
                            controller: cifController,
                            onChanged: (String value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'CIF de la sociedad',
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Representación en BankOpinion:",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(220, 42, 7, 107)),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButton<String>(
                              value: selectedOption,
                              hint: Text('Selecciona una opción'),
                              items: options.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {

                                  selectedOption = value;

                                });
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Descripción:",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(220, 42, 7, 107)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: descController,
                            onChanged: (String value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Describa en un máximo de 60 palabras el objeto de los servicios que presta la sociedad. \nSerá visible para los usuarios.',
                            ),
                            maxLines: 10,
                            minLines: 5,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(60 * 5), // Limita el número total de caracteres
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                // Limita el número de palabras
                                if (newValue.text.split(' ').length > 60) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dirección:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: addressController,
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Dirección de la sociedad',
                                ),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Imagen de la sociedad:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final picker = ImagePicker();
                                          final pickedImage = await picker.getImage(source: ImageSource.gallery);
                                           setState(() {

                                          if (pickedImage != null) {
                                            imageFile = pickedImage;
                                          } else {
                                            
                                          }
                                          print(imageFile);
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white, // Fondo blanco
                                      onPrimary: Color.fromARGB(220, 42, 7, 107), // Letras de color
                                      onSurface: Color.fromARGB(220, 42, 7, 107), // Bordes de color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(
                                          color: Color.fromARGB(220, 42, 7, 107), // Bordes de color
                                          width: .7, // Ancho de los bordes
                                        ),
                                      ),
                                    ),
                                    child: Text('Subir imagen'),
                                  ),

                                ]
                              )
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ciudad:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: DropdownButton<String>(
                                      value: selectedCiudad,
                                      hint: Text('Selecciona una ciudad'),
                                      items: ciudades.map((String ciudad) {
                                        return DropdownMenuItem<String>(
                                          value: ciudad,
                                          child: Text(ciudad),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCiudad = newValue;
                                        });
                                      },
                                    )),
                              ],
                            )
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: EdgeInsets.only(top: 15),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Costo de los servicios:",
                        //             style: TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color.fromARGB(220, 42, 7, 107)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Padding(
                        //           padding: EdgeInsets.symmetric(vertical: 10),
                        //           child: DropdownButton<String>(
                        //             value: selectedAmount,
                        //             hint: Text('Selecciona una opción'),
                        //             items: _options.map((String value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Text(value),
                        //               );
                        //             }).toList(),
                        //             onChanged: (String? newValue) {
                        //               setState(() {
                        //                 if (newValue == '€ (Económico)') {
                        //                   _selectedAmount = '€';
                        //                 }
                        //                 if (newValue == '€€ (Moderado)') {
                        //                   _selectedAmount = '€€';

                        //                 }
                        //                 if (newValue == '€€€ (Alto)') {
                        //                   _selectedAmount = '€€€';

                        //                 }
                        //                 selectedAmount = newValue;
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Horarios de atención:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: scheduleController,
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText:
                                      'Redactar en el siguiente formato: \nL-V: 10:00-14:00/16:00-18:00 \nS: 10:00-15:00',
                                ),
                                maxLines: 10,
                                minLines: 5,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Teléfono de contacto:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: phoneController,
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Ej: 611091992',
                                ),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email de contacto:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: emailController,
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Ej: contacto@bankopinion.es',
                                ),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Página web:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(220, 42, 7, 107)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: webController,
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Ej: www.bankopinion.es',
                                ),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
                        err == true
                            ? Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: RichText(
                                  text: const TextSpan(
                                    text: "Debes completar todos los campos",
                                    style: TextStyle(
                                        color: Color.fromARGB(143, 255, 0, 0),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),

                                err1 == true
                            ? Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: RichText(
                                  text: const TextSpan(
                                    text: "Se ha producido un error",
                                    style: TextStyle(
                                        color: Color.fromARGB(143, 255, 0, 0),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: (() async {
                                    if (titleController.text != "" &&
                                        emailController.text != "" &&
                                        descController.text != "" &&
                                        phoneController.text != "" &&
                                        webController.text != "" &&
                                        scheduleController.text != "" &&                                        
                                        addressController.text != "" &&
                                        cifController.text != ""
                                        ) {

                                          print("hola");
                                      newProfessionalRequest();
                                      setState(() {
                                        err = false;
                                      });
                                      
                                    } else {
                                      setState(() {
                                        err = true;
                                      });
                                    }
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 40),
                                    backgroundColor: const Color.fromARGB(
                                        255, 153, 116, 223),
                                  ),
                                  child: const Text("Enviar",
                                      style: TextStyle(fontSize: 16)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
   void _showAlertDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              color: Color.fromARGB(56, 233, 221, 255),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "La solicitud se ha enviado correctamente.\nSu petición se revisará y se notificará mediante correo en un plazo de 1 a 3 días laborables.",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Gracias",
                    style: TextStyle(color: Color.fromARGB(255, 61, 19, 139),
                    fontWeight: FontWeight.bold),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 153, 116, 223)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => allProfessionalsView(),
                              ),
                            );
                          },
                          child: Text(
                            "Vale",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
