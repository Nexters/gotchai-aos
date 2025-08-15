import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/datasources/remote/profile_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/my_solved_test_response.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'my_solved_test_view_model.g.dart';

sealed class MySolvedTestState {
  const MySolvedTestState();
}

class MySolvedTestInitial extends MySolvedTestState {
  const MySolvedTestInitial();
}

class MySolvedTestLoading extends MySolvedTestState {
  const MySolvedTestLoading();
}

class MySolvedTestLoaded extends MySolvedTestState {
  final List<MySolvedTest> list;
  const MySolvedTestLoaded(this.list);
}

class MySolvedTestFailure extends MySolvedTestState {
  final String message;
  const MySolvedTestFailure(this.message);
}

@riverpod
class MySolvedTestViewModel extends _$MySolvedTestViewModel {
  @override
  MySolvedTestState build() {
    return MySolvedTestInitial();
  }

  void navigateToback() {
    NavigationService().goBack();
  }

  Future<void> getMySolvedTestList() async {
    await ProfileService().getMySolvedTestList().then((result) {
      if (result is Success<MySolvedTestResponse>) {
        state = MySolvedTestLoaded(result.data.list);
      } else if (result is Error<MySolvedTestResponse>) {
        state = MySolvedTestFailure(result.message);
      }
    }).catchError((error) {
      state = MySolvedTestFailure(error.toString());
    });
  }
}
