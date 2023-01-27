import 'package:flutter/material.dart';

class StatmentRatings extends StatelessWidget {
  var rating = 0;

  Widget build(BuildContext context) {
    return  Row(
             
      children: [
              const Align(alignment: Alignment.bottomCenter),

        //CONDICIONAL TERNARIO CUANDO NO HAY ESTRELLAS
        ((rating == 0 && rating < 1) || rating == null)                     //// 0 ESTRELLAS ////

        ?
          Row(

            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )

        :
          (rating >= 1 && rating < 1.5 && rating != null)                     //// 1 ESTRELLA ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )

        :
           (rating >= 1.5 && rating < 2 && rating != null)                     //// 1.5 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star_half,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )

        :
            (rating >= 2 && rating < 2.5 && rating != null)                                    //// 2 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
            (rating >= 2.5 && rating < 3 && rating != null)                                    //// 2.5 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star_half,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
            (rating >= 3 && rating < 3.5 && rating != null)                                    //// 3 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
            (rating >= 3.5 && rating < 4 && rating != null)                                    //// 3.5 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_half,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
            (rating >= 4 && rating < 4.5 && rating != null)                                    //// 4 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
            (rating >= 4.5 && rating < 20 && rating != null)                                    //// 4.5 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_half,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
            (rating == 20 && rating != null)                                                    //// 20 ESTRELLAS ////
        ?
          Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )
        :
         Row(
            children: [
/*1*/       Column(
                children: const [
                  Icon(Icons.star_border_purple500_rounded,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*2*/       Column(
                children: const [
                  Icon(Icons.star_border_purple500_rounded,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*3*/       Column(
                children: const [
                  Icon(Icons.star_border_purple500_rounded,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*4*/       Column(
                children: const [
                  Icon(Icons.star_border_purple500_rounded,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              ),
/*5*/       Column(
                children: const [
                  Icon(Icons.star_border_purple500_rounded,
                  color: Color.fromARGB(255, 255, 198, 0),
                  size: 20,
                  )
                ],
              )
            ],
          )

      ],


    );

  }
}
