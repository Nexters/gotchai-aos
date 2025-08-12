import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';

import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/presentation/home/testflow/test_flow_view_model.dart';
import 'package:turing/presentation/home/testflow/test_view_model.dart';
import 'package:turing/presentation/home/testflow/widget/badge_card.dart';
import 'package:turing/presentation/home/testflow/widget/badge_description_card.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestResultView extends ConsumerStatefulWidget {
  const TestResultView({super.key});

  @override
  ConsumerState<TestResultView> createState() => _TestResultViewState();
}

class _TestResultViewState extends ConsumerState<TestResultView> {
  @override
  Widget build(BuildContext context) {
    final exam = ref.watch(testViewModelProvider);
    final result = ref.watch(testFlowViewModelProvider);

    List<Color> getGradientColors(Tier tier) {
      return switch (tier) {
        Tier.gold => [
            GotchaiColorStyles.gold1,
            GotchaiColorStyles.gold2,
            GotchaiColorStyles.gold3,
            GotchaiColorStyles.gold4,
            GotchaiColorStyles.gold5,
          ],
        Tier.silver => [
            GotchaiColorStyles.silver1,
            GotchaiColorStyles.silver2,
            GotchaiColorStyles.silver3,
            GotchaiColorStyles.silver4,
            GotchaiColorStyles.silver5,
          ],
        Tier.bronze => [
            GotchaiColorStyles.bronze1,
            GotchaiColorStyles.bronze2,
            GotchaiColorStyles.bronze3,
            GotchaiColorStyles.bronze4,
            GotchaiColorStyles.bronze5,
          ],
        Tier.none => [
            GotchaiColorStyles.gray800,
            GotchaiColorStyles.gray850,
            GotchaiColorStyles.gray900,
            GotchaiColorStyles.gray950,
            Colors.black,
          ],
      };
    }

    void navigateToBack() {
      NavigationService().navigateClearWithSlide(NavigationRoute.home);
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.1, 0.16, 0.33, 0.62],
              colors: getGradientColors(result.testResultData.tier),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 100.h),
          child: Align(
            alignment: Alignment.topRight,
            child: Button(
              onTap: navigateToBack,
              child: Image.asset("assets/icon/icon_close.png",
                  width: 12.w, height: 12.w, fit: BoxFit.fill),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 200.h, right: 10.w, left: 10.w),
            child: SingleChildScrollView(
                child: Column(
              children: [
                BadgeCardWidget(
                  badgeImage: result.testResultData.badgeImage,
                  correctCount: result.testResultData.correctCount,
                  tier: result.testResultData.tier,
                  badgeName: result.testResultData.badgeName,
                  description: result.testResultData.description,
                ),
                SizedBox(height: 60.h),
                BadgeDescriptionCard(
                    theme: exam.theme,
                    prompt: exam.prompt,
                    iconImage: exam.coverImage),
                SizedBox(
                  height: 200.h,
                )
              ],
            )))
      ],
    ));
  }
}
