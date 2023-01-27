import 'dart:async';
import 'dart:convert';


import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

// class PageHomePage extends StatefulWidget {
//   const PageHomePage({super.key});

//   @override
//   State<PageHomePage> createState() => StateHomePage();
// }

// class StateHomePage extends State<PageHomePage> {
//   late TextEditingController _controller;

// var banks = [];

//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse(
//         'https://bankopinion-backend-development-897ht.ondigitalocean.app/branches/'));

//     setState(() {
//       banks = jsonDecode(response.body);
//     });
//   } 
// }