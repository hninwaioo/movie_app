import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/widgets/rating_view.dart';

import '../resources/dimens.dart';

class MovieView extends StatelessWidget {

  final Function onTapMovie;
  MovieView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              onTapMovie();
              print("movieItemTap");
            },
            child:  Image.network("https://flxt.tmsimg.com/assets/p16746497_p_v8_ab.jpg",
              height: BANNER_SECTION_HEIGHT,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM,),
          Text(
            "The Nightingale",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM,),
          Row(
            children: [
              Text(
                "8.8",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR
                ),
              ),
              SizedBox(width: MARGIN_MEDIUM,),
              RatingView()
            ],
          )
        ],
      )
    );
  }
}
