
import 'package:json_annotation/json_annotation.dart';

part 'delete_schedule_data.g.dart';
@JsonSerializable()
class  DeleteScheduleData {
  final DateTime? date;


DeleteScheduleData({this.date});
  factory DeleteScheduleData.fromJson(Map<String, dynamic> json) =>
      _$DeleteScheduleDataFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteScheduleDataToJson(this);


}