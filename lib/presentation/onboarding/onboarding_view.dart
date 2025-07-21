import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/presentation/onboarding/onboarding_view_model.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: PageController(initialPage: state.currentPage),
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
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SvgPicture.asset(
                          data['image']!,
                          width: double.infinity,
                          height: 300.h,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          data['text']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.h,
                            fontWeight: FontWeight.w500,
                          ),
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
                  width: 8.w,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        state.currentPage == index ? Colors.black : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 96.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  if (state.currentPage < viewModel.onboardingData.length - 1) {
                    viewModel.updatePage(state.currentPage + 1);
                  } else {
                    NavigationService().navigateClearTo(NavigationRoute.login);
                  }
                },
                child: Text(
                  style: const TextStyle(color: Colors.white),
                  state.buttonText,
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
