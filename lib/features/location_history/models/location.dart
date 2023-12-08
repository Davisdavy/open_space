import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class LocationHistory {
  final String street;
  final double longitude;
  final String item;
  final double latitude;
  final String updatedAt;
  final String id;
  final String image;


  LocationHistory({
    required this.street,
    required this.longitude,
    required this.item,
    required this.latitude,
    required this.updatedAt,
    required this.id,
    required this.image
  });

  factory LocationHistory.fromJson(Map<String, dynamic> json) =>
      _$LocationHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$LocationHistoryToJson(this);
}
