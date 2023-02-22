import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FavoritesService extends StatefulWidget {
  const FavoritesService({super.key});

  @override
  State<FavoritesService> createState() => _FavoritesServiceState();
}



class _FavoritesServiceState extends State<FavoritesService>  {
  String? jwt;
  String? refresh_token;
  int? expires_in;
  late List<dynamic> userBranchesFavorites = [];




  Future<void> fetchData() async {}

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  
    Future<void> getUserProfile() async {
        final prefs = await SharedPreferences.getInstance();
        jwt = prefs.getString("jwt");
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
                var name = responseData["userProfile"]["name"];
                var surname = responseData["userProfile"]["surname"];
                var nickname = responseData["userProfile"]["username"];

          //GUARDAMOS EN SHAREDPREFERENCES LOS VALORES RECUPERADOS
                prefs.setString('user_id', userId);
                prefs.setString('name', name);
                prefs.setString('surname', surname);
                prefs.setString('nickname', nickname);
                prefs.setStringList('favoriteBranches',
                    userBranchesFavorites.map((e) => json.encode(e)).toList());
              
                });
              }
               
    }
    
      @override
      Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
      }
}
