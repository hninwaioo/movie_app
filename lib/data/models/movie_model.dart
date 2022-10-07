import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../vos/credit_vo.dart';
import '../vos/genres_vo.dart';

abstract class MovieModel {

  // Network
  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getPopularMovies(int page);

  Future<List<GenresVO>?> getGenres();
  Future<List<ActorVO>?> getActors(int page);

  Future<List<MovieVO>?> getTopRateMovies(int page);

  Future<List<MovieVO>?> getMoviesByGenre(int page);

  Future<MovieVO> getMovieDetails (int movieId);
  Future<List<CreditVO>?> getCreditsByMovie(int movieId);

  // Database
  Future<List<MovieVO>?> getTopRateMoviesFromDatabase();
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>?> getPopularMoviesFromDatabase();
  Future<List<GenresVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getAllActorsFromDatabase();
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId);

}