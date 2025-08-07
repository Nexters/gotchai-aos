// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamListResponse _$ExamListResponseFromJson(Map<String, dynamic> json) =>
    ExamListResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => Exam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamListResponseToJson(ExamListResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      description: json['description'] as String,
      prompt: json['prompt'] as String,
      backgroundImage: json['backgroundImage'] as String,
      iconImage: json['iconImage'] as String,
      theme: json['theme'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'description': instance.description,
      'prompt': instance.prompt,
      'backgroundImage': instance.backgroundImage,
      'iconImage': instance.iconImage,
      'theme': instance.theme,
      'createdAt': instance.createdAt,
    };
