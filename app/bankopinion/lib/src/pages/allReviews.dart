import 'package:flutter/material.dart';

class allReviews extends StatelessWidget {


   var rating = 0;


  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 110, 14, 14),
      body: 
      Column(
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            width: 600.0,
            height: 240.0,
            // child: Image.asset(
            //     'assets/images/streetView.jpeg',
            //     width: 600.0,
            //     height: 240.0,
            //     fit: BoxFit.cover,
            //   ),
            
          ),
          Row(
            children: [
              Column(

              )
            ],
          ) 
      ]
    ),
      
    );
  }
}