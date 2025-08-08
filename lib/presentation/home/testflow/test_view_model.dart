import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/models/test_list_response.dart';

part 'test_view_model.g.dart';

@riverpod
class TestViewModel extends _$TestViewModel {
  @override
  Test build() {
    return Test.empty();
  }

  void setCurTestInfo(Test test) {
    state = test;
  }

  void clearCurTestInfo() {
    state = Test.empty();
  }
}
