import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_view_model.g.dart';

class OnboardingState {
  final int currentPage;
  final String buttonText;
  final bool isLastPage;

  OnboardingState(
      {required this.currentPage,
      required this.buttonText,
      required this.isLastPage});

  OnboardingState copyWith({
    int? currentPage,
    String? buttonText,
    bool? isLastPage,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      buttonText: buttonText ?? this.buttonText,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}

@riverpod
class OnboardingViewModel extends _$OnboardingViewModel {
  @override
  OnboardingState build() {
    return OnboardingState(currentPage: 0, buttonText: '다음', isLastPage: false);
  }

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/image/image_onboarding1.png',
      'text': 'AI와 사람의 경계가 희미해진 시대에서 안녕하신가요?',
    },
    {
      'image': 'assets/image/image_onboarding2.png',
      'text': '다양한 테마의 퀴즈에서 Ai가 작성한 대답을 선택해요.',
    },
    {
      'image': 'assets/image/image_onboarding3.png',
      'text': 'Ai의 답변을 모두 맞추고 뱃지를 모아 보아요',
    },
    {
      'image': 'assets/image/image_onboarding4.png',
      'text': '그럼, 사람 사이에 숨은 AI를 찾으러 가 볼까요?',
    },
  ];

  void updatePage(int pageIndex) {
    final isLastPage = pageIndex == onboardingData.length - 1;
    state = state.copyWith(
        currentPage: pageIndex,
        buttonText: isLastPage ? '시작하기' : '다음',
        isLastPage: isLastPage);
  }
}
