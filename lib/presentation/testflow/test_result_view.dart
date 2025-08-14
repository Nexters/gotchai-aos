import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/core/utils/permission_util.dart';

import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/testflow/test_flow_view_model.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/presentation/testflow/widget/badge_card.dart';
import 'package:turing/presentation/testflow/widget/badge_description_card.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestResultView extends ConsumerStatefulWidget {
  const TestResultView({super.key});

  @override
  ConsumerState<TestResultView> createState() => _TestResultViewState();
}

class _TestResultViewState extends ConsumerState<TestResultView> {
  final GlobalKey _badgeCardKey = GlobalKey();

  Future<void> saveBadgeCardAsImage() async {
    try {
      bool hasPermission =
          await PermissionUtils.handleStoragePermission(context);

      if (!hasPermission) {
        return;
      }

      final boundary = _badgeCardKey.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final uint8List = byteData.buffer.asUint8List();

        await Gal.putImageBytes(
          uint8List,
          album: "Gotchai", // 앨범 이름
          name: "gotchai_badge_${DateTime.now().millisecondsSinceEpoch}.png",
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "배지 이미지가 갤러리에 저장되었습니다!",
                style: GotchaiTextStyles.body3,
              ),
              backgroundColor: GotchaiColorStyles.gray700,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      }
    } catch (e) {
      logger.e("이미지 저장 실패: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "이미지 저장에 실패했습니다: ${e.toString()}",
              style: GotchaiTextStyles.body3,
            ),
            backgroundColor: GotchaiColorStyles.gray700,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

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

    List<Color> getGradientTopColors(Tier tier) {
      return switch (tier) {
        Tier.gold => [GotchaiColorStyles.goldTop1, GotchaiColorStyles.goldTop2],
        Tier.silver => [
            GotchaiColorStyles.silverTop1,
            GotchaiColorStyles.silverTop2
          ],
        Tier.bronze => [
            GotchaiColorStyles.bronzeTop1,
            GotchaiColorStyles.bronzeTop2
          ],
        Tier.none => [
            GotchaiColorStyles.gray800,
            GotchaiColorStyles.gray850,
          ],
      };
    }

    void navigateToBack() {
      NavigationService().navigateClearWithSlide(NavigationRoute.home);
    }

    void copyPromptToClipboard() async {
      await Clipboard.setData(ClipboardData(text: exam.prompt));
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
            padding: EdgeInsets.only(
                right: Constants.horizontalPadding,
                left: Constants.horizontalPadding),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 200.h),
                RepaintBoundary(
                  key: _badgeCardKey,
                  child: BadgeCardWidget(
                    badgeImage: result.testResultData.badgeImage,
                    correctCount: result.testResultData.correctCount,
                    tier: result.testResultData.tier,
                    badgeName: result.testResultData.badgeName,
                    description: result.testResultData.description,
                  ),
                ),
                SizedBox(height: 60.h),
                BadgeDescriptionCard(
                  theme: exam.theme,
                  prompt: exam.prompt,
                  iconImage: exam.coverImage,
                  onTap: copyPromptToClipboard,
                ),
                SizedBox(
                  height: 400.h,
                )
              ],
            ))),
        Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: getGradientTopColors(result.testResultData.tier),
            stops: [0.0, 1.0],
          )),
          child: Padding(
            padding: EdgeInsets.only(right: 6.w, bottom: 6.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Button(
                onTap: navigateToBack,
                child: Image.asset("assets/icon/icon_close.png",
                    width: Constants.iconSize,
                    height: Constants.iconSize,
                    fit: BoxFit.fill),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              height: 400.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: GotchaiColorStyles.gray950,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(21, 21, 25, 0),
                      Color.fromRGBO(21, 21, 25, 1.0),
                      Color.fromRGBO(21, 21, 25, 1.0),
                    ],
                    stops: const [
                      0.0,
                      0.5,
                      1.0
                    ]),
              ),
              child: Padding(
                  padding: EdgeInsets.only(bottom: Constants.topPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: Button(
                              onTap: saveBadgeCardAsImage,
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: GotchaiColorStyles.primary100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icon/icon_save.png",
                                    width: Constants.iconSize,
                                    height: Constants.iconSize,
                                  ),
                                  Text(
                                    " 이미지 저장",
                                    style: GotchaiTextStyles.body3
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ))),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: Button(
                              onTap: () {},
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: GotchaiColorStyles.primary400,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icon/icon_insta.png",
                                    width: Constants.iconSize,
                                    height: Constants.iconSize,
                                  ),
                                  Text(
                                    " 배지 공유",
                                    style: GotchaiTextStyles.body3
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ))),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ))),
        )
      ],
    ));
  }
}
