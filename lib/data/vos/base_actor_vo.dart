import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'base_actor_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BASE_ACTOR_VO, adapterName : "BaseActorVOAdapter")
class BaseActorVo{
  @JsonKey(name: "name")
  @HiveField(10)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(11)
  String? profilePath;

  BaseActorVo(this.name, this.profilePath);

  factory BaseActorVo.fromJson(Map<String,dynamic> json) => _$BaseActorVoFromJson(json);

  Map<String,dynamic> toJson() => _$BaseActorVoToJson(this);
}