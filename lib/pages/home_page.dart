import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/bannerview.dart';
import 'package:movie_app/viewitems/movieview.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genres_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../widgets/actor_and_creator_section_view.dart';
import '../widgets/see_more_text.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MovieModel mMovieModel = MovieModelImpl();

  // List<String> genreList = [
  //   "Now Showing",
  //   "Adventure",
  //   "Horror",
  //   "Comedy",
  //   "Thriller",
  //   "Drama"
  // ];

  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMoviesList;
  List<GenresVO>? mGenreList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMovieList;
  List<MovieVO>? mMoviesByGenreList;

  @override
  void initState() {
    super.initState();

    /// Now Playing Movies
    mMovieModel.getNowPlayingMovies(1).then((movieList){
      setState((){
        mNowPlayingMovieList = movieList;
        print("mNowPlayingMovie==>${mNowPlayingMovieList}");
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Now Playing Movies DataBase
    mMovieModel.getNowPlayingMoviesFromDatabase().then((movieList){
      setState((){
       mNowPlayingMovieList = movieList;
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Now Popular Movies
    mMovieModel.getPopularMovies(1).then((movieList){
      setState((){
        mPopularMoviesList = movieList;
        print("mNowPlayingMovie==>${mPopularMoviesList}");
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Now Popular Movies DataBase
    mMovieModel.getNowPlayingMoviesFromDatabase().then((movieList) {
      setState((){
        mPopularMoviesList = movieList;
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Get Genres
    mMovieModel.getGenres().then((genreList){
      setState((){
        mGenreList = genreList;
        _getMoviesByGenreAndRefresh(mGenreList?.first.id ?? 0);
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Get Genres DataBase
    mMovieModel.getGenresFromDatabase().then((genreList) {
      setState((){
        mGenreList = genreList;
        _getMoviesByGenreAndRefresh(mGenreList?.first.id ?? 0);
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Get Actors
    mMovieModel.getActors(1).then((actorList){
      setState((){
        mActors = actorList;
        print("mNowPlayingMovie==>${mActors}");
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Get Actors DataBase
    mMovieModel.getAllActorsFromDatabase().then((actorList){
      setState((){
        mActors = actorList;
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Get Top Rate Movies View
    mMovieModel.getTopRateMovies(1).then((rateMoviesList){
      setState((){
        mShowCaseMovieList = rateMoviesList;
        print("mNowPlayingMovie==>${mShowCaseMovieList}");
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    /// Get Top Rate Movie View DataBase
    mMovieModel.getTopRateMoviesFromDatabase().then((rateMoviesList) {
      setState((){
        mShowCaseMovieList = rateMoviesList;
      });
    }).catchError((error){
      debugPrint("ERROR=>${error.toString()}");
    });

    // /// Get Movies By Genre
    // mMovieModel.getMoviesByGenre(1).then((genreMoviesList){
    //   setState((){
    //     mMoviesByGenreList = genreMoviesList;
    //     print("mNowPlayingMovie==>${mMoviesByGenreList}");
    //   });
    // }).catchError((error){
    //   debugPrint("ERROR=>${error.toString()}");
    // });
  }

  void _getMoviesByGenreAndRefresh(int genreId){
    mMovieModel.getMoviesByGenre(genreId).then((movieByGenre){
      setState((){
        mMoviesByGenreList = movieByGenre;
      });

    }).catchError((error){
      debugPrint(error.toString());
    });
  }

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
                    BannerSectionView(
                      mPopularMovies: mPopularMoviesList?.take(8).toList(),
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    BestPopularMovieAndSeriesSectionView(
                        (movieId) => _navigateToMoviesDetailScreen(context,movieId),
                      mNowPlayingMovieList?? []
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    CheckMovieShowTimeSectionView(),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    GenreSectionView(
                        genreList: mGenreList?? [],
                        mMoviesByGenreList: mMoviesByGenreList?? [],
                        onTapMovie: (movieId) => _navigateToMoviesDetailScreen(context,movieId),
                        onTapGenre: (genreId) {
                          print("GenreId===>${genreId}");
                          _getMoviesByGenreAndRefresh(genreId);
                        }
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),
                    ShowCasesSection(
                      mShowCaseMovieList?? []
                    ),
                    SizedBox(height: MARGIN_MEDIUM_LARGE,),

                    ActorAndCreatorSectionView(
                      BEST_ACTOR_TITLE,
                      BEST_ACTOR_SEE_MORE,
                      mActorList: mActors?? [],
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

  Future<dynamic> _navigateToMoviesDetailScreen(BuildContext context,int movieId) {
    return Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId)
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

  final List<MovieVO> mShowCaseMovieList;

  ShowCasesSection(this.mShowCaseMovieList);

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
          child: (mShowCaseMovieList!=null)
              ?
          ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: mShowCaseMovieList
              .map((showCaseMovie) => ShowCaseView(mMovieVo: showCaseMovie))
              .toList()

          ): Center(
            child: CircularProgressIndicator(),
          )
        ),
      ],
    );
  }
}

class BestPopularMovieAndSeriesSectionView extends StatelessWidget {

  final Function(int) onTapMovie;

  final List<MovieVO> mNowPlayingMovieList;

  BestPopularMovieAndSeriesSectionView(this.onTapMovie, this.mNowPlayingMovieList);
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
        HorizontalMovieListView(
            (movieId){
              onTapMovie(movieId);
            },
          movieList: mNowPlayingMovieList,
        )
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {

  final Function(int) onTapMovie;
  final List<MovieVO> movieList;

  HorizontalMovieListView(this.onTapMovie,{required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: movieList.length,
          itemBuilder:(BuildContext context, int index){
            return MovieView(
                (movieId){
                  this.onTapMovie(movieId);
                },
              movieList[index],
            );
          }
      )
    );
  }
}

class GenreSectionView extends StatelessWidget {
   GenreSectionView(
       {
         required this.genreList,
         required this.mMoviesByGenreList,
         required this.onTapMovie,
         required this.onTapGenre

  });

  final List<GenresVO> genreList;
   final List<MovieVO> mMoviesByGenreList;

  final Function onTapMovie;
  final Function (int) onTapGenre;

   // final List<MovieVo> mNowPlayingMovieList;

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
              onTap: (index){
                this.onTapGenre(genreList[index].id??0);
              },
              tabs: genreList.map(
                        (genre) => Tab(
                          child: Text(genre.name!),
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
          child: HorizontalMovieListView(
              (movieId){
                onTapMovie(movieId);
              },
            movieList: mMoviesByGenreList,
          ),
        )
      ],
    );
  }
}

class BannerSectionView extends StatefulWidget {

  List<MovieVO>? mPopularMovies;
  BannerSectionView({required this.mPopularMovies});

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
            children: widget.mPopularMovies?.map((popularMovie) => BannerView(
              mMovieVo: popularMovie,
            ))
              .toList() ?? []
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        DotsIndicator(
            dotsCount: widget.mPopularMovies?.length?? 1,
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
