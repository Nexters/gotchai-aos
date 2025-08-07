import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/models/exam_list_response.dart';

part 'test_view_model.g.dart';

@riverpod
class TestViewModel extends _$TestViewModel {
  @override
  Exam build() {
    return Exam.empty();
  }

  void setCurTestInfo(Exam exam) {
    state = exam;
  }

  void clearCurTestInfo() {
    state = Exam.empty();
  }
}
