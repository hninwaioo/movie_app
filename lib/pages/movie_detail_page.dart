import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:movie_app/widgets/actor_and_creator_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import '../data/vos/credit_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  MovieDetailPage(this.movieId);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  MovieModel mMovieModel = MovieModelImpl();
  MovieVO? mMovieVo;
  List<BaseActorVo>? mActorsList;
  List<BaseActorVo>? mCreatorsList;

  @override
  void initState(){
    super.initState();
    mMovieModel.getMovieDetails(widget.movieId)
    .then((movie) {
      setState((){
        this.mMovieVo = movie;
      });
    });

    mMovieModel.getMovieDetailsFromDatabase(widget.movieId)
    .then((movie) {
      setState((){
        this.mMovieVo = movie;
      });
    });

    mMovieModel.getCreditsByMovie(widget.movieId)
    .then((creditsList){

      setState((){
        this.mActorsList = creditsList?.where((credit) => credit.isActor()).toList();
        this.mCreatorsList = creditsList?.where((credit) => credit.isCreator()).toList();

      });
    });
  }

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
        child: (mMovieVo != null)
          ?
        CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(
                () => Navigator.pop(context),
              mMovieVo,
            ),

            SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSection(mMovieVo),
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    ActorAndCreatorSectionView(
                      MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                      "",
                      seeMoreButtonVisibility: false,
                      mActorList: this.mActorsList??[],
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: AboutFlimSectionView(mMovieVo),
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    (mCreatorsList != null&& mCreatorsList!.isNotEmpty) ?
                    ActorAndCreatorSectionView(
                        MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                        MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                      mActorList: this.mCreatorsList??[],
                    ): Container()
                  ]
                )
            )
          ],
        )
            :
            Center(
              child: CircularProgressIndicator(),
            )
      ),
    );
  }
}

class AboutFlimSectionView extends StatelessWidget {

  MovieVO? mMovie;
  AboutFlimSectionView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
          "Origin Title",
          mMovie?.originalTitle ??"",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Type",
            mMovie?.genres?.map((genre) => genre.name).join(",")?? "",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Production",
          mMovie?.productionCountries?.map((country) => country.name).join(",")?? ""
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Premiere",
            mMovie?.releaseDate?? "",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Description",
          mMovie?.overview??"",
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

  MovieVO? mMovie;
  TrailerSection(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(
            genreList: mMovie?.genres?.map((genre) => genre.name).toList()?? []
        ),
        StoryLineView(mMovie?.overview),

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

  String? storyLine;
  StoryLineView(this.storyLine);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(width: MARGIN_MEDIUM_2,),
        Text(
          this.storyLine?? "",
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

  final List<String?> genreList;

  @override
  Widget build(BuildContext context) {
    return
      Wrap(
          alignment : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.horizontal,
          children: _createMovieTimeAndGenreWidget()
    );
  }

  List<Widget> _createMovieTimeAndGenreWidget(){
    List<Widget> widgets = [
      Icon(
        Icons.access_time,
        color: PLAY_BUTTON_COLOR,
      ),
      SizedBox(width: MARGIN_SMALL,),
      Container(
        child:  Text("2hr 30min",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      SizedBox(width: MARGIN_MEDIUM,)
    ];
    widgets.addAll(genreList.map((genre) => GenreChipView(genre??"")).toList());

    widgets.add(
      Icon(Icons.favorite_border_outlined,
        color: Colors.white,),
    );
    return widgets;
  }
}

class GenreChipView extends StatelessWidget {

  final String genreText;
  GenreChipView(this.genreText);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
  MovieVO? mMovie;
  MovieDetailsSliverAppBarView(this.onTapBack,this.mMovie);
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
                child: MovieDetailsAppBarImageView(mMovie?.posterPath),
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
                child: MovieDetailAppBarInfoView(mMovie),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {

  MovieVO? mMovie;
  MovieDetailAppBarInfoView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailYearView(mMovie?.releaseDate?.substring(0,4)),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(height: MARGIN_SMALL,),
                    TitleText("${mMovie?.voteCount} VOTES"),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2,)
                  ],
                ),
                SizedBox(width: MARGIN_MEDIUM_2,),
                Text(
                  "${mMovie?.voteAverage}",
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
          mMovie?.title?? "",
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

  String? year;
  MovieDetailYearView(this.year);

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
          year?? "",
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

  String? movieImage;
  MovieDetailsAppBarImageView(this.movieImage);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      // "https://i.guim.co.uk/img/media/f1c7f5c3af5f903c96889b075187a54594d9f4a1/0_0_2500_1500/master/2500.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=b665ebda8b877f93527bc4e58de62a5f",
      "$IMAGE_BASE_URL$movieImage",
      fit: BoxFit.cover,
    );
  }
}
