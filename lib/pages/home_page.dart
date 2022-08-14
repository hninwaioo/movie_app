import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/viewitems/bannerview.dart';
import 'package:movie_app/viewitems/movieview.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import '../resources/dimens.dart';
import '../widgets/actor_and_creator_section_view.dart';
import '../widgets/see_more_text.dart';
import 'movie_detail_page.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Center(
          child:   Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(
                fontWeight: FontWeight.w700
            ),
          ),
        ),

        leading: Icon(
          Icons.menu,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: MARGIN_MEDIUM_2),
            child: Icon(
              Icons.search
            ),
          )
        ],
      ),

      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    BannerSectionView(),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    BestPopularMovieAndSeriesSectionView(
                        () => _navigateToMoviesDetailScreen(context)
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    CheckMovieShowTimeSectionView(),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    GenreSectionView(() =>
                        _navigateToMoviesDetailScreen(context)
                    ,genreList: genreList),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    ShowCasesSection(),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    ActorAndCreatorSectionView(
                      BEST_ACTOR_TITLE,
                      BEST_ACTOR_SEE_MORE
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,)
                  ],
                ),
              ],
            )
        )
      ),
    );
  }

  Future<dynamic> _navigateToMoviesDetailScreen(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MovieDetailPage()
                          )
                        );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_MEDIUM_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,

      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MAIN_SCREEN_MOVIES_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1x,
                  fontWeight: FontWeight.w600
                ),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
              textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: CHECK_MOVIE_LOCATION,
          )
        ],
      ),
    );
  }
}


class ShowCasesSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
                SHOW_CASES_TITLE,
                SHOW_CASES_SEE_MORE
            )
        ),
        SizedBox(height: MARGIN_MEDIUM,),
        Container(
          height: MOVIE_LIST_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: [

              ShowCaseView(),
              ShowCaseView(),
              ShowCaseView()
            ],
          ),
        ),
      ],
    );
  }
}

class BestPopularMovieAndSeriesSectionView extends StatelessWidget {

  final Function onTapMovie;
  BestPopularMovieAndSeriesSectionView(this.onTapMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          alignment: Alignment.topLeft,
          child: TitleText(BEST_POPULAR_MOVIES_AND_SERIES),
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        HorizontalMovieistView(
            (){
              onTapMovie();
            }
        )
      ],
    );
  }
}

class HorizontalMovieistView extends StatelessWidget {

  final Function onTapMovie;
  HorizontalMovieistView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: 10,
          itemBuilder:(BuildContext context, int index){
            return MovieView(
                (){
                  this.onTapMovie();
                }
            );
          }
      )
    );
  }
}

class GenreSectionView extends StatelessWidget {
   GenreSectionView(this.onTapMovie,{
    required this.genreList,
  });
  final List<String> genreList;
  final Function onTapMovie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList.map(
                        (genre) => Tab(
                          child: Text(genre),
                        )
                ).toList(),
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_MEDIUM_LARGE
          ),
          child: HorizontalMovieistView(
              (){
                onTapMovie();
              }
          ),
        )
      ],
    );
  }
}


class BannerSectionView extends StatefulWidget {

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  var _position = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/3,
          child: PageView(
            onPageChanged: (page){
              setState((){
                _position = page.toDouble();
              });
            },
            children: [
              BannerView(),
              BannerView()
            ],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        DotsIndicator(
            dotsCount: 2,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR
          ),
        )
      ],
    );
  }
}
