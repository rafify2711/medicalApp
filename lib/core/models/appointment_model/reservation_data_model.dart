
import 'package:json_annotation/json_annotation.dart';


part 'reservation_data_model.g.dart';

@JsonSerializable()
class ReservationDataModel {
  final String doctorId;
  final String userId;
  final DateTime date;
  final String? timeSlot;

  ReservationDataModel({
    required this.doctorId,
    required this.date,
    required this.userId,
    this.timeSlot
  });

  factory ReservationDataModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationDataModelToJson(this);
}



