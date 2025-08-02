import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/presentation/onboarding/onboarding_view_model.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);

    final PageController pageController =
        PageController(initialPage: state.currentPage);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  viewModel.updatePage(index);
                },
                itemCount: viewModel.onboardingData.length,
                itemBuilder: (context, index) {
                  final data = viewModel.onboardingData[index];
                  return Column(
                    children: [
                      SizedBox(height: 500.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Image.asset('assets/icon/gotchai_logo.png',
                            width: double.infinity, height: 500.h),
                      ),
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Text(
                          data['text']!,
                          textAlign: TextAlign.center,
                          style: GotchaiTextStyles.body1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                viewModel.onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 0.1.w),
                  width: 6.w,
                  height: 6,
                  decoration: BoxDecoration(
                    color: state.currentPage == index
                        ? GotchaiColorStyles.primary400
                        : GotchaiColorStyles.gray700,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 120.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: GotchaiColorStyles.primary400,
                ),
                onPressed: () {
                  if (state.currentPage < viewModel.onboardingData.length - 1) {
                    pageController.animateToPage(
                      state.currentPage + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    viewModel.updatePage(state.currentPage + 1);
                  } else {
                    NavigationService().navigateClearTo(NavigationRoute.login);
                  }
                },
                child: Text(
                  style: GotchaiTextStyles.body2.copyWith(color: Colors.black),
                  state.buttonText,
                ),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
