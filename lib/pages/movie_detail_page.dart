import 'package:flutter/material.dart';
import 'package:movie_app/widgets/actor_and_creator_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class MovieDetailPage extends StatelessWidget {

  final List<String> genreList = [
    "Action",
    "Adventure",
    "Thriller"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(
                () => Navigator.pop(context)
            ),

            SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSection(genreList),
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    ActorAndCreatorSectionView(
                      MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                      "",
                      seeMoreButtonVisibility: false,),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: AboutFlimSectionView(),
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    ActorAndCreatorSectionView(
                        MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                        MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE)
                  ]
                )
            )
          ],
        ),
      ),
    );
  }
}

class AboutFlimSectionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
          "Origin Title",
          "THE NIGHTINAGLE "
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Type",
            "Action, Adventure, Thriller"
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Production",
            "Causeway Films"
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Premiere",
            "29 August 2019 (Australia)"
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Description",
            "The film received positive reviews for its performances, atmosphere, cinematography, screenplay, scope, and acknowledgement of racial violence in Australia."
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {

  final String label;
  final String description;

  AboutFilmInfoView(this.label,this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/4,
          child: Text(
          label,
          style: TextStyle(
            color: MOVIE_DETAIL_INFO_TEXT,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w600

          ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2,),
        Expanded(
            child: Text(
              description,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w600

              ),
            ),
        )

      ],
    );
  }
}

class TrailerSection extends StatelessWidget {

  final List<String> genreList;
  TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        StoryLineView(),

        Row(
          children: [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(Icons.play_circle_filled,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: MARGIN_CARD_MEDIUM_2,),
            MovieDetailsScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )

      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {

  final String btnText;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.btnText,
      this.backgroundColor,
      this.buttonIcon,
      {this.isGhostButton=false}
      );
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
          height: MARGIN_XXLARGE,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                  MARGIN_MEDIUM_LARGE
              ),
              border: (isGhostButton)
                  ? Border.all(
                  color: Colors.white,
                  width: 2
              )
                  :null
          ),
          child: Center(
            child: Row(
              children: [
                buttonIcon,
                SizedBox(width: MARGIN_MEDIUM,),
                Flexible(
                    child:Text(
                      btnText,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_2X,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                )
              ],
            ),
          ),
        )

    );

  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(width: MARGIN_MEDIUM_2,),
        Text("Clare, a young Irish convict, chases a British officer through the rugged Tasmanian wilderness and is bent on revenge for a terrible act of violence the man committed against her family. On the way, she enlists the services of Aboriginal tracker Billy, who is marked by trauma from his own violence-filled past.",
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM_2,),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return
      Wrap(
        alignment : WrapAlignment.start,
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(width: MARGIN_SMALL,),
        Text("2hr 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM,),
        Row(
          children: genreList.map((genre) => GenreChipView(genre))
              .toList()

        ),
        Spacer(),
        Icon(Icons.favorite_border_outlined,
        color: Colors.white,),

      ],
    );
  }
}

class GenreChipView extends StatelessWidget {

  final String genreText;
  GenreChipView(this.genreText);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
        ),
        SizedBox(width: MARGIN_SMALL,)
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {

  final Function onTapBack;
  MovieDetailsSliverAppBarView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background:
        Stack(
          children: [
            Positioned.fill(
                child: MovieDetailsAppBarImageView(),
            ),
            Positioned.fill(
                child: GradientView()
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2
                ),
                child: BackButtonView(
                    () => onTapBack()
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE+MARGIN_MEDIUM,
                    right: MARGIN_MEDIUM_2
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_MEDIUM_LARGE
                ),
                child: MovieDetailAppBarInfoView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(height: MARGIN_SMALL,),
                    TitleText("38876 VOTES"),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2,)
                  ],
                ),
                SizedBox(width: MARGIN_MEDIUM_2,),
                Text(
                  "9,76",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,

                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM,),
        Text(
          "The NIGHTINAGLE",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}

class MovieDetailYearView extends StatelessWidget {
  const MovieDetailYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_LARGE),
      ),
      child: Center(
        child: Text(
          "2018",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  BackButtonView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: (){
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black54
        ),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
      
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://i.guim.co.uk/img/media/f1c7f5c3af5f903c96889b075187a54594d9f4a1/0_0_2500_1500/master/2500.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=b665ebda8b877f93527bc4e58de62a5f",
      fit: BoxFit.cover,
    );
  }
}
