import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../data/vos/actor_vo.dart';
import '../data/vos/credit_vo.dart';

abstract class MovieDataAgent{
  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getPopularMovies(int page);
  Future<List<MovieVO>?> getTopRateMovies(int page);
  Future<List<GenresVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);

  Future<MovieVO> getMovieDetails (int movieId);
  Future<List<CreditVO>?> getCreditsByMovie(int movieId);
}