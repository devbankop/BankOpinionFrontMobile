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

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://bankopinion-backend-development-897ht.ondigitalocean.app/branches/'));

    setState(() {
      banks = jsonDecode(response.body);
    });
  }

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
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
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
                          hintText: "Filtra por localización"),
                    )),
                    const Icon(Icons.location_searching_sharp)
                  ]))),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: banks.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100
                  ),
                    height: 100,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(banks.elementAt(index)["address"],
                            textAlign: TextAlign.left),
                        Text(banks.elementAt(index)["id"].toString(),
                            textAlign: TextAlign.left),
                      ],
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
