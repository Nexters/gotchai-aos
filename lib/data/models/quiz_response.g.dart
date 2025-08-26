// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) => QuizResponse(
      id: (json['id'] as num).toInt(),
      contents: json['contents'] as String,
      createdAt: json['createdAt'] as String,
      quizPicks: (json['quizPicks'] as List<dynamic>)
          .map((e) => QuizPick.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contents': instance.contents,
      'createdAt': instance.createdAt,
      'quizPicks': instance.quizPicks,
    };

QuizPick _$QuizPickFromJson(Map<String, dynamic> json) => QuizPick(
      id: (json['id'] as num).toInt(),
      contents: json['contents'] as String,
    );

Map<String, dynamic> _$QuizPickToJson(QuizPick instance) => <String, dynamic>{
      'id': instance.id,
      'contents': instance.contents,
    };
