// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_badge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBadgeResponse _$MyBadgeResponseFromJson(Map<String, dynamic> json) =>
    MyBadgeResponse(
      badges: (json['badges'] as List<dynamic>)
          .map((e) => MyBadgeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalBadgeCount: (json['totalBadgeCount'] as num).toInt(),
    );

Map<String, dynamic> _$MyBadgeResponseToJson(MyBadgeResponse instance) =>
    <String, dynamic>{
      'badges': instance.badges,
      'totalBadgeCount': instance.totalBadgeCount,
    };

MyBadgeItem _$MyBadgeItemFromJson(Map<String, dynamic> json) => MyBadgeItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      acquiredAt: json['acquiredAt'] as String,
    );

Map<String, dynamic> _$MyBadgeItemToJson(MyBadgeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'acquiredAt': instance.acquiredAt,
    };
