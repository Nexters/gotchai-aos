import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'my_solved_test_view_model.g.dart';

@riverpod
class MySolvedTestViewModel extends _$MySolvedTestViewModel {
  @override
  List<String> build() {
    return [];
  }

  void navigateToback() {
    NavigationService().goBack();
  }

  Future<void> getMySolvedTest() async {
    state = [
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
      "test1",
      "test2",
    ];
  }
}
