import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/data/datasources/remote/test_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/grade_quiz_response.dart';
import 'package:turing/data/models/quiz_response.dart';
import 'package:turing/data/models/test_start_response.dart';

part 'test_flow_view_model.g.dart';

class ContentData {
  final int id;
  final String content;

  ContentData({
    required this.id,
    required this.content,
  });
}

class CurQuizData {
  final String question;
  final ContentData contentAData;
  final ContentData contentBData;
  final int selectQuizPick;
  CurQuizData({
    required this.question,
    required this.contentAData,
    required this.contentBData,
    required this.selectQuizPick,
  });

  CurQuizData copyWith({
    String? question,
    ContentData? contentAData,
    ContentData? contentBData,
    int? selectQuizPick,
  }) {
    return CurQuizData(
      question: question ?? this.question,
      contentAData: contentAData ?? this.contentAData,
      contentBData: contentBData ?? this.contentBData,
      selectQuizPick: selectQuizPick ?? this.selectQuizPick,
    );
  }
}

class TestFlowState {
  final int examId;
  final int timer;
  final List<int> quizIds;
  final int curIndex;
  final CurQuizData curQuizData;

  TestFlowState(
      {required this.examId,
      required this.timer,
      required this.quizIds,
      required this.curIndex,
      required this.curQuizData});

  TestFlowState copyWith({
    int? examId,
    int? timer,
    List<int>? quizIds,
    int? curIndex,
    CurQuizData? curQuizData,
  }) {
    return TestFlowState(
      examId: examId ?? this.examId,
      timer: timer ?? this.timer,
      quizIds: quizIds ?? this.quizIds,
      curIndex: curIndex ?? this.curIndex,
      curQuizData: curQuizData ?? this.curQuizData,
    );
  }
}

@riverpod
class TestFlowViewModel extends _$TestFlowViewModel {
  Timer? _countdownTimer;

  @override
  TestFlowState build() {
    return TestFlowState(
      examId: 0,
      timer: 0,
      quizIds: [],
      curIndex: 0,
      curQuizData: CurQuizData(
        question: '',
        contentAData: ContentData(id: 0, content: ''),
        contentBData: ContentData(id: 0, content: ''),
        selectQuizPick: -1,
      ),
    );
  }

  Future<void> startTest(int examId) async {
    await TestService().postTestStart(examId).then((result) {
      if (result is Success<TestStartResponse>) {
        final data = result.data;
        state = state.copyWith(
          examId: examId,
          quizIds: data.quizIds,
          curIndex: 0,
        );
        loadNextQuiz();
      } else if (result is Error<TestStartResponse>) {
        // Handle error
      }
    }).catchError((error) {});
  }

  Future<void> loadNextQuiz() async {
    final quizId = state.quizIds[state.curIndex];
    await TestService().getQuiz(quizId).then((result) {
      if (result is Success<QuizResponse>) {
        state = state.copyWith(
          curIndex: state.curIndex + 1,
          curQuizData: CurQuizData(
              question: result.data.contents,
              contentAData: ContentData(
                id: result.data.quizPicks[0].id,
                content: result.data.quizPicks[0].contents,
              ),
              contentBData: ContentData(
                id: result.data.quizPicks[1].id,
                content: result.data.quizPicks[1].contents,
              ),
              selectQuizPick: -1),
        );

        // 타이머 스타트
        startCountdown();
      } else if (result is Error<QuizResponse>) {
        // Handle error
      }
    }).catchError((error) {});
  }

  void startCountdown({int seconds = 10}) {
    _countdownTimer?.cancel();

    state = state.copyWith(timer: seconds);

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final currentTime = state.timer - 1;
      logger.d("타이머: $currentTime");
      if (currentTime <= 0) {
        timer.cancel();
        state = state.copyWith(timer: 0);
        _onTimerEnd();
      } else {
        state = state.copyWith(timer: 10 - currentTime);
      }
    });
  }

  void selectAnswer(int quizPickId) {
    state = state.copyWith(
        curQuizData: state.curQuizData.copyWith(
      selectQuizPick: quizPickId,
    ));
    gradeQuiz();
    stopCountdown();
  }

  Future<void> gradeQuiz() async {
    final quizId = state.quizIds[state.curIndex - 1];

    await TestService()
        .postGradeQuiz(quizId, state.curQuizData.selectQuizPick)
        .then((result) {
      if (result is Success<GradeQuizResponse>) {
        if (result.data.isAnswer) {
          // 정답모달 띄우기
          logger.d("정답입니다");
        } else {
          logger.d("오답입니다");
        }
      } else if (result is Error<GradeQuizResponse>) {}
    }).catchError((error) {});
  }

  void goNext() {
    if (state.curIndex < state.quizIds.length) {
      loadNextQuiz();
    } else {
      logger.d("모든 퀴즈가 끝났습니다.");
      endTest();
    }
  }

  Future<void> endTest() async {}

  void _onTimerEnd() {
    gradeQuiz();
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  void resetTimer({int seconds = 10}) {
    stopCountdown();
    state = state.copyWith(timer: seconds);
  }
}
