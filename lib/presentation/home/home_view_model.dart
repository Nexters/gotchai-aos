import 'package:turing/data/datasources/remote/test_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/exam_list_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Exam> examList;

  const HomeLoaded(this.examList);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    getExamList();
    return const HomeInitial();
  }

  Future<void> getExamList() async {
    await TestService().getExamList().then((result) {
      if (result is Success<ExamListResponse>) {
        state = HomeLoaded(result.data.list);
      } else if (result is Error<ExamListResponse>) {
        state = HomeError(result.message);
      }
    }).catchError((error) {
      state = HomeError('예상치 못한 오류가 발생했습니다: ${error.toString()}');
    });
  }
}
