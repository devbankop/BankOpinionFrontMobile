import 'dart:async';
import 'dart:convert';

import 'package:bankopinion/src/models/Bank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class PageHomePage extends StatefulWidget {
  const PageHomePage({super.key});

  @override
  State<PageHomePage> createState() => _StateHomePage();
}

class _StateHomePage extends State<PageHomePage> {
  late TextEditingController _controller;

  var banks = [];

  Future<void> fetchData() async { }

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color.fromARGB(255, 224, 224, 224)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
                    const Icon(
                      Icons.search,
                    ),
                    Expanded(
                      
                        child: TextField(
                          
                      controller: _controller,
                      onSubmitted: (value) => {},
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Filtra por ubicación"),
                          
                    )),
                    const Icon(Icons.location_searching_sharp)
                  ]))),
        ]
      ),
    );
  }
}
