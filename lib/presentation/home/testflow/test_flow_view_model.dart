import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/models/quiz_response.dart';

part 'test_flow_view_model.g.dart';

sealed class TestFlowState {
  const TestFlowState();
}

class TestFlowInitial extends TestFlowState {
  const TestFlowInitial();
}

class TestFlowLoading extends TestFlowState {
  const TestFlowLoading();
}

class TestFlowLoaded extends TestFlowState {
  final QuizResponse curQuizData;

  const TestFlowLoaded(this.curQuizData);
}

class TestFlowError extends TestFlowState {
  final String message;

  const TestFlowError(this.message);
}

@riverpod
class TestFlowViewModel extends _$TestFlowViewModel {
  @override
  TestFlowState build() {
    return const TestFlowInitial();
  }
}
