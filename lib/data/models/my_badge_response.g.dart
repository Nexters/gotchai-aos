// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_badge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBadgeResponse _$MyBadgeResponseFromJson(Map<String, dynamic> json) =>
    MyBadgeResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => MyBadgeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyBadgeResponseToJson(MyBadgeResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

MyBadgeItem _$MyBadgeItemFromJson(Map<String, dynamic> json) => MyBadgeItem(
      id: (json['id'] as num).toInt(),
      examId: (json['examId'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      tier: json['tier'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$MyBadgeItemToJson(MyBadgeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'examId': instance.examId,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'tier': instance.tier,
      'createdAt': instance.createdAt,
    };
