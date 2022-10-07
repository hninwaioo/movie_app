import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';
part 'credit_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CREDIT_VO, adapterName: "CreditVOAdapter")
class CreditVO extends BaseActorVo {

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "gender")
  @HiveField(1)
  int? gender;

  @JsonKey(name: "id")
  @HiveField(2)
  int? id;

  @JsonKey(name: "known_for_department")
  @HiveField(3)
  String? knownForDepartment;

  // @JsonKey(name:"name")
  // String? name;

  @JsonKey(name: "original_name")
  @HiveField(4)
  String? originalName;

  @JsonKey(name: "popularity")
  @HiveField(5)
  double? popularity;

  // @JsonKey(name: "profile_path")
  // String? profile_path;

  @JsonKey(name: "cast_id")
  @HiveField(6)
  int? cast_id;

  @JsonKey(name: "character")
  @HiveField(7)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(8)
  String? credit_id;

  @JsonKey(name: "order")
  @HiveField(9)
  int? order;

  CreditVO(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      // this.name,
      this.originalName,
      this.popularity,
      // this.profile_path,
      this.cast_id,
      this.character,
      this.credit_id,
      this.order,
      String? name,
      String? profilePath,
      ): super (name, profilePath);

  factory CreditVO.fromJson(Map<String,dynamic> json) => _$CreditVOFromJson(json);

  Map<String,dynamic> toJson() => _$CreditVOToJson(this);

  bool isActor(){
    return knownForDepartment == KNOWN_FOR_DEPARTMENT_ACTING;
  }
  bool isCreator(){
    return knownForDepartment != KNOWN_FOR_DEPARTMENT_ACTING;
  }
}

const String KNOWN_FOR_DEPARTMENT_ACTING = "Acting";