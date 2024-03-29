import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';

import '../data/vos/movie_vo.dart';
import '../network/api_constant.dart';
import '../widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {

  MovieVO? mMovieVo;
  ShowCaseView({this.mMovieVo});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: SHOW_CASE_HEIGHT,
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.network(
                // "https://cinemaaustralia.files.wordpress.com/2019/08/the-nightingale-cinema-australia-featured-1.jpg",
                "$IMAGE_BASE_URL${mMovieVo!.posterPath!}",
                fit: BoxFit.cover,
              )
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    mMovieVo!.title!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                      fontWeight: FontWeight.w600
                    ),
                  ),

                  SizedBox(height: MARGIN_MEDIUM),
                  TitleText(
                      "18 JUNE 2018",
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
