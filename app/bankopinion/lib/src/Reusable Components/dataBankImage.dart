import 'package:flutter/material.dart';

class StatmentDataBankImage extends StatelessWidget {
  var rating = 0;

  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width * 1;

    return Column(
        children: [
          Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.asset(
                'assets/images/streetView.jpeg',
                width: screenWidth,
                height: 265.0,
                //fit: BoxFit.cover,
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Container(
          //       color: Color.fromARGB(255, 255, 255, 255),
          //       height: 140,
          //       width: 240,
                
          //       child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [

          //                   Padding(
          //                     padding: const EdgeInsets.only(bottom: 6, top: 8),
          //                     child: Text(
                                
          //                         banks.elementAt(index)["name"],
          //                         textAlign: TextAlign.left,
          //                         style: const TextStyle(
          //                             fontSize: 18,
          //                             color: Color.fromARGB(255, 0, 0, 0),
          //                             fontWeight: FontWeight.bold)),
          //                   ),
                              
          //                     Container(
          //                         constraints: const BoxConstraints(maxWidth: 200),

          //                     child: Text(                               
          //                     banks.elementAt(index)["vicinity"],
          //                       textAlign: TextAlign.left,
          //                       style: const TextStyle(
          //                         fontSize: 11,
                                  
          //                         color: Color.fromARGB(255, 0, 0, 0),
          //                       )),
          //                     ),
                              
                            
          //                   Row(
                              
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.only(top: 6, bottom: 4), 
          //                         child: StatmentRatings(),
          //                       ),
          //                       const Padding(
          //                         padding: EdgeInsets.only(top: 6, bottom: 4), 
          //                         child: Text("()", 
          //                               style: TextStyle(
          //                         fontSize: 12,
          //                         color: Color.fromARGB(255, 66, 66, 66),
          //                       )),
          //                       )
          //                     ],
          //                   )
                                                         

          //                 ],
          //               )
          //     ),
          //   ],
          // ),
        ]);
  }
}
