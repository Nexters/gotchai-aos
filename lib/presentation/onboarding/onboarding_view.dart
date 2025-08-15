import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/presentation/onboarding/onboarding_view_model.dart';
import 'package:turing/widgets/button.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);

    final PageController pageController =
        PageController(initialPage: state.currentPage);

    void onNextTab() {
      if (state.currentPage < viewModel.onboardingData.length - 1) {
        pageController.animateToPage(
          state.currentPage + 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );

        viewModel.updatePage(state.currentPage + 1);
      } else {
        NavigationService().navigateWithSlide(
          NavigationRoute.login,
        );
      }
    }

    void skipOnboarding() {
      NavigationService().navigateWithSlide(
        NavigationRoute.login,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Constants.topPadding,
          ),
          Padding(
              padding: EdgeInsets.only(right: 32.w),
              child: Align(
                alignment: Alignment.topRight,
                child: Button(
                    onTap: skipOnboarding,
                    child: Text(
                      state.isLastPage ? "" : "건너뛰기",
                      style: GotchaiTextStyles.body5
                          .copyWith(color: GotchaiColorStyles.gray400),
                    )),
              )),
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
                    SizedBox(height: 68.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 43.w),
                      child: Image.asset(
                        data['image']!,
                        width: 307.w,
                        height: 348.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 44.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 68.w),
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
          SizedBox(height: 78.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              viewModel.onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 6.w),
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
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Button(
              onTap: onNextTab,
              width: double.infinity,
              height: 57.h,
              child: Container(
                width: double.infinity,
                height: 57.h,
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.primary400,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    state.buttonText,
                    style:
                        GotchaiTextStyles.body2.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
