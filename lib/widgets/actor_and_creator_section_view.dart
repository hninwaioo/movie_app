import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import '../data/vos/actor_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewitems/actor_view.dart';

class ActorAndCreatorSectionView extends StatelessWidget {

  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<BaseActorVo> mActorList;

  ActorAndCreatorSectionView(
      this.titleText,
      this.seeMoreText,
      {this.seeMoreButtonVisibility = true,required this.mActorList});

  @override
  Widget build(BuildContext context) {
    return (mActorList != null)
      ?
      Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(
          top: MARGIN_MEDIUM_2,
          bottom: MARGIN_XXLARGE
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: TitleTextWithSeeMoreView(
                  titleText,
                  seeMoreText,
                seeMoreButtonVisibility: this.seeMoreButtonVisibility,
              )
          ),
          SizedBox(height: MARGIN_MEDIUM_2,),
          Container(
            height: BEST_ACTOR_HEIGHT,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              children: mActorList
                .map((actor) => ActorView(
                  mActorVo: actor
              )).toList()
                // ActorView(),
                // ActorView(),
                // ActorView()

            ),
          ),
        ],
      ),
    ):
        Center(
          child: CircularProgressIndicator(),
        );
  }
}
