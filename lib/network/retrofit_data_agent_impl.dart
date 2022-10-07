import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:movie_app/network/the_movie_api.dart';

import 'movie_data_agent.dart';

class RetrofitDataAgentImpl extends MovieDataAgent{
  late TheMovieApi mApi;

 static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

 factory RetrofitDataAgentImpl(){
   return _singleton;
 }

  RetrofitDataAgentImpl._internal(){
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mApi.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }


  @override
  Future<List<ActorVO>?> getActors(int page) {
   return mApi.getActors(API_KEY, LANGUAGE_EN_US, page.toString())
       .asStream()
       .map((response) => response.results)
       .first;
  }

  @override
  Future<List<GenresVO>?> getGenres() {
   return mApi.getGenres(API_KEY, LANGUAGE_EN_US)
       .asStream()
       .map((response) => response.genres)
       .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mApi.getMoviesByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mApi.getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRateMovies(int page) {

   return mApi.getTopRateMovies(API_KEY, LANGUAGE_EN_US, page.toString())
       .asStream()
       .map((response) => response.results)
       .first;
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return mApi.getCreditByMovieResponse(movieId.toString(),API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
   return mApi.getMovieDetails(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString());
  }
}