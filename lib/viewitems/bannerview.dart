import 'package:flutter/material.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import '../data/vos/movie_vo.dart';
import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {

  MovieVO? mMovieVo;
  BannerView({this.mMovieVo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child:
            BannerImageView(
              mImageUrl: mMovieVo?.posterPath,
            ),
        ),
        Positioned.fill(
            child: GradientView()
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(
            bannerTitle: mMovieVo?.title,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView()
        )
      ],

    );
  }
}

class BannerImageView extends StatelessWidget {
  String? mImageUrl;

  BannerImageView({this.mImageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
        // "https://imusic.b-cdn.net/images/item/original/892/5060192819892.jpg?movie-2020-the-nightingale-dvd&class=scaled",

        "$IMAGE_BASE_URL$mImageUrl",
        fit:BoxFit.cover
    );
  }
}

class BannerTitleView extends StatelessWidget {

  String? bannerTitle;
  BannerTitleView({this.bannerTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bannerTitle!,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1x,
              fontWeight: FontWeight.w500
            ),
          ),
          Text("The best movie Hulu right now",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1x,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}
