import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckUserRol {
  static Future<bool> isAdmin() async {
    // Obtiene el token JWT almacenado en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');


    Uri user = Uri.parse('ENDPOINT');

    // Envía una solicitud a una API protegida con el token JWT en la cabecera
    final response = await http.get(
      user,
      headers: {
        'Authorization': 'Bearer $jwt',
      },
    );

    // Si el servidor devuelve un código de estado 200 (OK), procesa la respuesta
    // para verificar si el usuario es un administrador o no
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = json.decode(response.body);
      return responseJson['isAdmin'];
    }

    // Si el servidor devuelve un código de estado 401 (No autorizado), es
    // probable que el token JWT sea inválido o haya expirado. En este caso,
    // devuelve false.
    return false;
  }
}
