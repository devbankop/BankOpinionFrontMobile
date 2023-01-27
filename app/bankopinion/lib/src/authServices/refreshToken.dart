import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  String? jwt;
  String? refresh_token;
  int? expires_in;

  AuthService();

  // Future<bool> isTokenValid() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   jwt = prefs.getString('jwt');
  //   expires_in = prefs.getInt("expires_in");
  //           final expiryTime =
  //           DateTime.now().millisecondsSinceEpoch / 1000 + (expires_in?? 0);

  //   if (jwt != null && jwt != '' && expiryTime < DateTime.now().millisecondsSinceEpoch / 1000) {
  //     return true;
  //   }
  //   return false;
  // }

  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    refresh_token = prefs.getString("refresh_token");
    jwt = prefs.getString('jwt');

    var _refresh = Uri.parse(
        'https://bankopinion-backend-development-3vucy.ondigitalocean.app/users/newSession');
    print(refresh_token);
    var response =
        await http.get(_refresh, headers: {'Authorization': '$refresh_token'});
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final jwt = data["session"]["access_token"];
      final refreshToken = data["session"]["refresh_token"];

      prefs.setString('jwt', jwt);
      prefs.setString('refresh_token', refreshToken);
    } else {
      throw Exception('Error al refrescar el token');
    }
  }
}
