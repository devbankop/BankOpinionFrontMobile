import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StatmentRatingsUser extends StatelessWidget {
 
  var bank;
  double rating = 0;
  
  StatmentRatingsUser( { required this.rating } )
  {
    this.rating = rating;
  }

   

  Widget build(BuildContext context) {
    return  Row(
             
      children: [
              const Align(alignment: Alignment.centerLeft),


                        RatingBarIndicator(
              rating: rating,
              itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
          ),

      ],


    );

  }
}
