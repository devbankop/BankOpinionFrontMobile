// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../pages/homeView.dart';


class linearBars extends StatelessWidget {

  var rating = 0;
  
  var bank;
  
  var index;

  linearBars({ required this.bank });


  Widget build(BuildContext context) {


    return  Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            
            

            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, bottom: 8),
              child: Column(

                children: <Widget>[
                  

              //1a LinearBar

                  Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                    children: [
                      const Text("1"),
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Color.fromARGB(255, 255, 198, 0),
                      ),
                      LinearPercentIndicator(
                        width: 140.0,
                        lineHeight: 10.0,
                        percent: bank["ratingSummary"]["1"]/10,
                        progressColor: const Color.fromARGB(255, 255, 198, 0),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                      ),
                       Text("(" + bank["ratingSummary"]["1"].toString() + " opiniones)",
                            style: TextStyle(
                            fontSize: 12
                      ), )
                    ],
                  )
                ),


              //2a LinearBar

                  Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                    children: [
                      const Text("2"),
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Color.fromARGB(255, 255, 198, 0),
                      ),
                      LinearPercentIndicator(
                        width: 140.0,
                        lineHeight: 10.0,
                        percent: bank["ratingSummary"]["2"]/10,
                        progressColor: const Color.fromARGB(255, 255, 198, 0),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                      ),
                       Text("(" + bank["ratingSummary"]["2"].toString() + " opiniones)",
                            style: TextStyle(
                            fontSize: 12
                      ), 
                      )
                    ],
                  )
                ),


              //3a LinearBar

                  Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                    children: [
                      const Text("3"),
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Color.fromARGB(255, 255, 198, 0),
                      ),
                      LinearPercentIndicator(
                        width: 140.0,
                        lineHeight: 10.0,
                        percent: bank["ratingSummary"]["3"]/10,
                        progressColor: const Color.fromARGB(255, 255, 198, 0),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                      ),
                       Text("(${bank["ratingSummary"]["3"]} opiniones)",
                            style: const TextStyle(
                            fontSize: 12
                      ), )
                    ],
                  )
                ),


              //4a LinearBar

                 Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                    children: [
                      const Text("4"),
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Color.fromARGB(255, 255, 198, 0),
                      ),
                      LinearPercentIndicator(
                        width: 140.0,
                        lineHeight: 10.0,
                        percent: bank["ratingSummary"]["4"]/10,
                        progressColor: const Color.fromARGB(255, 255, 198, 0),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                      ),
                       Text("(" + bank["ratingSummary"]["4"].toString() + " opiniones)",
                            style: const TextStyle(
                            fontSize: 12
                      ), )
                    ],
                  )
                ),


              //5a LinearBar
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                    children: [
                      const Text("5"),
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Color.fromARGB(255, 255, 198, 0),
                      ),
                      LinearPercentIndicator(
                        width: 140.0,
                        lineHeight: 10.0,
                        percent: bank["ratingSummary"]["5"]/10,
                        progressColor: const Color.fromARGB(255, 255, 198, 0),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                      ),
                       Text("(" + bank["ratingSummary"]["5"].toString() + " opiniones)",
                            style: TextStyle(
                            fontSize: 12
                      ), )
                    ],
                  )
                )
                  
                ],
              ),
            ),
          ],
        );
  }
}