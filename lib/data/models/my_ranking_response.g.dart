// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_ranking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRankingResponse _$MyRankingResponseFromJson(Map<String, dynamic> json) =>
    MyRankingResponse(
      name: json['name'] as String,
      rating: (json['rating'] as num).toInt(),
    );

Map<String, dynamic> _$MyRankingResponseToJson(MyRankingResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
    };
