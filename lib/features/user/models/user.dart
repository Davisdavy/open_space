import 'package:json_annotation/json_annotation.dart';
import 'package:on_space/features/user/models/location.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.locations,
    required this.createdAt,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String id;
  final String name;
  final String avatar;
  final List<Location> locations;
  final String createdAt;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}