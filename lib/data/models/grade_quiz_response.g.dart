// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_quiz_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeQuizResponse _$GradeQuizResponseFromJson(Map<String, dynamic> json) =>
    GradeQuizResponse(
      contents: json['contents'] as String,
      isAnswer: json['isAnswer'] as bool,
    );

Map<String, dynamic> _$GradeQuizResponseToJson(GradeQuizResponse instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'isAnswer': instance.isAnswer,
    };
