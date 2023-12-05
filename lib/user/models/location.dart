import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
  });
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final String id;
  final String name;
  final String longitude;
  final String latitude;

  Map<String, dynamic> toJson() => _$LocationToJson(this);

}
