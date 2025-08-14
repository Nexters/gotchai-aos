import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/datasources/remote/profile_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/my_solved_test_response.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'my_solved_test_view_model.g.dart';

@riverpod
class MySolvedTestViewModel extends _$MySolvedTestViewModel {
  @override
  List<MySolvedTest> build() {
    return [];
  }

  void navigateToback() {
    NavigationService().goBack();
  }

  Future<void> getMySolvedTestList() async {
    await ProfileService().getMySolvedTestList().then((result) {
      if (result is Success<MySolvedTestResponse>) {
        state = result.data.list;
      } else if (result is Error<MySolvedTestResponse>) {}
    }).catchError((error) {});
  }
}
