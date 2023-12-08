// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationHistory _$LocationHistoryFromJson(Map<String, dynamic> json) =>
    LocationHistory(
      street: json['street'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      item: json['item'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      updatedAt: json['updatedAt'] as String,
      id: json['id'] as String,
          image: json['image'] as String,
    );

Map<String, dynamic> _$LocationHistoryToJson(LocationHistory instance) =>
    <String, dynamic>{
      'street': instance.street,
      'longitude': instance.longitude,
      'item': instance.item,
      'latitude': instance.latitude,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
          'image': instance.image
    };
