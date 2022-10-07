import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class GenreDao {
  static final GenreDao _singleton = GenreDao._internal();

  factory GenreDao(){
    return _singleton;
  }

  GenreDao._internal();

  void savedAllGenres(List<GenresVO> genreList) async {
    Map<int, GenresVO> genreMap = Map.fromIterable(genreList,
        key: (genre) => genre.id, value: (genre) => genre);
    await getGenreBox().putAll(genreMap);
  }

  List<GenresVO> getAllGenres(){
    return getGenreBox().values.toList();
  }

  Box<GenresVO> getGenreBox(){
    return Hive.box<GenresVO>(BOX_NAME_GENRE_VO);
  }
}