import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  /// NetWork
  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO>? nowPlayingMovies = movies?.map((movie){
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.savedAllMovies(nowPlayingMovies??[]);
      return Future.value(movies);
    });
  }

  @override
  Future<List<GenresVO>?> getGenres() {
    return mDataAgent.getGenres().then((genres) async {
      mGenreDao.savedAllGenres(genres??[]);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mDataAgent.getPopularMovies(page).then((movies){
      List<MovieVO>? popularMovies = movies?.map((movie){
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.savedAllMovies(popularMovies??[]);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getTopRateMovies(int page) {
    return mDataAgent.getTopRateMovies(page).then((movies) {
      List<MovieVO>? topRateMovies = movies?.map((movie){
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      mMovieDao.savedAllMovies(topRateMovies??[]);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mDataAgent.getActors(page).then((actors){
      mActorDao.savedAllActors(actors??[]);
      return Future.value(actors);
    });
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  /// DataBase

  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenresVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Future.value(mMovieDao
    .getAllMovies()
    .where((movie) => movie.isNowPlaying ?? true)
    .toList());
  }

  @override
  Future<List<MovieVO>?> getPopularMoviesFromDatabase() {
    return Future.value(mMovieDao
    .getAllMovies()
    .where((movie) => movie.isPopular ?? true)
    .toList());
  }

  @override
  Future<List<MovieVO>?> getTopRateMoviesFromDatabase() {
    return Future.value(mMovieDao
    .getAllMovies()
    .where((movie) => movie.isTopRated ?? true)
    .toList());
  }

}