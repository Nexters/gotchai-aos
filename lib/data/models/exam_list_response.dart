import 'package:json_annotation/json_annotation.dart';

part 'exam_list_response.g.dart';

@JsonSerializable()
class ExamListResponse {
  final List<Exam> list;

  ExamListResponse({
    required this.list,
  });

  factory ExamListResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamListResponseToJson(this);
}

@JsonSerializable()
class Exam {
  final int id;
  final String title;
  final String subTitle;
  final String description;
  final String prompt;
  final String backgroundImage;
  final String iconImage;
  final String theme;
  final String createdAt;

  Exam({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.prompt,
    required this.backgroundImage,
    required this.iconImage,
    required this.theme,
    required this.createdAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
