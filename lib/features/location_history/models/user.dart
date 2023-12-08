import 'package:json_annotation/json_annotation.dart';
import 'package:on_space/features/location_history/models/location.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String avatar;
  final List<LocationHistory> locationHistory;
  final String id;

  User({
    required this.name,
    required this.avatar,
    required this.locationHistory,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

