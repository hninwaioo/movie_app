import '../../persistence/hive_constants.dart';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'date_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_DATE_V0, adapterName: "DateVOAdapter")
class DateVO {
  @JsonKey(name: "maximum")
  @HiveField(0)
  String? maximum;

  @JsonKey(name: "minimum")
  @HiveField(1)
  String? minimum;

  DateVO(this.maximum, this.minimum);

  factory DateVO.fromJson(Map<String,dynamic> json) => _$DateVOFromJson(json);


  Map<String,dynamic> toJson() => _$DateVOToJson(this);

}