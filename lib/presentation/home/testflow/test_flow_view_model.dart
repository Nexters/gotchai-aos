import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/datasources/remote/test_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/grade_quiz_response.dart';
import 'package:turing/data/models/quiz_response.dart';
import 'package:turing/data/models/test_end_response.dart';
import 'package:turing/data/models/test_start_response.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/presentation/popup/test_flow_popup.dart';

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

sealed class CurQuizState {
  const CurQuizState();
}

class CurQuizInitial extends CurQuizState {
  const CurQuizInitial();
}

class CurQuizLoading extends CurQuizState {
  const CurQuizLoading();
}

class CurQuizLoaded extends CurQuizState {
  const CurQuizLoaded();
}

class CurQuizEnd extends CurQuizState {
  final QuizResult result;
  final String? answer;

  const CurQuizEnd(this.result, {this.answer});
}

enum Tier {
  none,
  bronze,
  silver,
  gold;

  static Tier fromString(String tier) {
    return switch (tier.toLowerCase()) {
      'bronze' => Tier.bronze,
      'silver' => Tier.silver,
      'gold' => Tier.gold,
      _ => Tier.none,
    };
  }
}

class TestResultData {
  final String badgeImage;
  final String badgeName;
  final String description;
  final Tier tier;
  final int correctCount;

  TestResultData({
    required this.badgeImage,
    required this.description,
    required this.badgeName,
    required this.tier,
    required this.correctCount,
  });

  factory TestResultData.fromTestEndResponse(TestEndResponse response) {
    return TestResultData(
      badgeImage: response.badge.image,
      description: response.badge.description,
      badgeName: response.badge.name,
      tier: Tier.fromString(response.badge.tier),
      correctCount: response.answerCount,
    );
  }
}

class TestFlowState {
  final int examId;
  final int timer;
  final List<int> quizIds;
  final int curIndex;
  final CurQuizData curQuizData;
  final CurQuizState curQuizState;
  final TestResultData testResultData;

  TestFlowState(
      {required this.examId,
      required this.timer,
      required this.quizIds,
      required this.curIndex,
      required this.curQuizData,
      required this.curQuizState,
      required this.testResultData});

  TestFlowState copyWith({
    int? examId,
    int? timer,
    List<int>? quizIds,
    int? curIndex,
    CurQuizData? curQuizData,
    CurQuizState? curQuizState,
    TestResultData? testResultData,
  }) {
    return TestFlowState(
      examId: examId ?? this.examId,
      timer: timer ?? this.timer,
      quizIds: quizIds ?? this.quizIds,
      curIndex: curIndex ?? this.curIndex,
      curQuizData: curQuizData ?? this.curQuizData,
      curQuizState: curQuizState ?? this.curQuizState,
      testResultData: testResultData ?? this.testResultData,
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
        curQuizState: CurQuizInitial(),
        testResultData: TestResultData(
          badgeImage: '',
          description: '',
          badgeName: '',
          tier: Tier.none,
          correctCount: 0,
        ));
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
        // Handle End
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
              selectQuizPick: -1,
            ),
            curQuizState: CurQuizLoaded());

        startCountdown();
      } else if (result is Error<QuizResponse>) {
        // Handle Error
      }
    }).catchError((error) {});
  }

  void startCountdown({int seconds = 10}) {
    _countdownTimer?.cancel();

    final totalMs = seconds * 1000;
    state = state.copyWith(timer: totalMs);

    _countdownTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      final currentTime = state.timer - 10;
      if (currentTime <= 0) {
        timer.cancel();
        state = state.copyWith(timer: 0);
        _onTimerEnd();
      } else {
        state = state.copyWith(timer: currentTime);
      }
    });
  }

  void selectAnswer(int quizPickId) {
    state = state.copyWith(
        curQuizData: state.curQuizData.copyWith(
      selectQuizPick: quizPickId,
    ));
    gradeQuiz(false);
    stopCountdown();
  }

  Future<void> gradeQuiz(bool isTimeout) async {
    final quizId = state.quizIds[state.curIndex - 1];

    await TestService()
        .postGradeQuiz(quizId, state.curQuizData.selectQuizPick, isTimeout)
        .then((result) {
      if (result is Success<GradeQuizResponse>) {
        final quizResult =
            switch ((result.data.isTimeout, result.data.isAnswer)) {
          (true, _) => QuizResult.timeout,
          (false, true) => QuizResult.correct,
          (false, false) => QuizResult.wrong,
        };

        state = state.copyWith(
          curQuizState: CurQuizEnd(quizResult, answer: result.data.contents),
        );
      } else if (result is Error<GradeQuizResponse>) {}
    }).catchError((error) {});
  }

  void goNext() {
    if (state.curIndex < state.quizIds.length) {
      loadNextQuiz();
    } else {
      endTest();
    }
  }

  Future<void> endTest() async {
    await TestService().postTestEnd(state.examId).then((result) {
      if (result is Success<TestEndResponse>) {
        state = state.copyWith(
          testResultData: TestResultData.fromTestEndResponse(result.data),
        );
        NavigationService().navigateClear(NavigationRoute.testResult);
      } else if (result is Error<TestEndResponse>) {}
    }).catchError((error) {});
  }

  void _onTimerEnd() {
    gradeQuiz(true);
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
