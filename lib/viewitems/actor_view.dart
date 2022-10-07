import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/resources/colors.dart';

import '../data/vos/actor_vo.dart';
import '../network/api_constant.dart';
import '../resources/dimens.dart';

class ActorView extends StatelessWidget {

  BaseActorVo? mActorVo;
  ActorView({required this.mActorVo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(right: MARGIN_MEDIUM),
        width: MOVIE_LIST_ITEM_WIDTH,
        child: Stack(
          children: [
            Positioned.fill(
                child: ActorImageView(
                  mImageUrl: mActorVo?.profilePath,
                )
            ),
            Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: Align(
                alignment: Alignment.topRight,
                child: FavouriteButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActorNameAndLikeView(actorName: mActorVo?.name,),

            )
          ],
        ),
      ),
    );
    
  }
}

class ActorImageView extends StatelessWidget {
  String? mImageUrl;

  ActorImageView({this.mImageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      // "https://static.wikia.nocookie.net/gameofthrones/images/d/d3/Aislng_Franciosi.jpg/revision/latest?cb=20190513215356",

      "$IMAGE_BASE_URL$mImageUrl",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  String? actorName;
  ActorNameAndLikeView({this.actorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              actorName?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM,),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
