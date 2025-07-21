import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      const SizedBox(height: 200),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SvgPicture.asset(
                          data['image']!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          data['text']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                viewModel.onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: state.currentPage == index ? 12 : 8,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
