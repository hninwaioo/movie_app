import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';
part 'spoken_languages_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SPOKEN_LANGUAGE_VO, adapterName: "SpokenLanguageVOAdapter")
class SpokenLanguagesVO{
  @JsonKey(name: "english_name")
  @HiveField(0)
  String? englishName;

  @JsonKey(name: "iso_639_1")
  @HiveField(1)
  String? isoEn;

  @JsonKey(name:"name")
  @HiveField(2)
  String? name;

  SpokenLanguagesVO(this.englishName, this.isoEn, this.name);

  factory SpokenLanguagesVO.fromJson(Map<String,dynamic> json) => _$SpokenLanguagesVOFromJson(json);

  Map<String,dynamic> toJson() => _$SpokenLanguagesVOToJson(this);
}