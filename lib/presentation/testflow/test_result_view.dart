import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/popup/custom_toast.dart';
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

  Future<void> instagramShare() async {
    try {
      final byteData = await getWidgetImage();
      if (byteData != null) {
        final uint8List = byteData.buffer.asUint8List();

        final dir = await getTemporaryDirectory();
        final file = File(
            '${dir.path}/badge_${DateTime.now().millisecondsSinceEpoch}.png');
        await file.writeAsBytes(uint8List);
        final params = ShareParams(
          files: [
            XFile(file.path),
          ],
        );

        await SharePlus.instance.share(params);
      }
    } catch (e) {
      logger.d(e);
    }
  }

  Future<void> saveBadgeCardAsImage() async {
    final byteData = await getWidgetImage();
    try {
      if (byteData != null) {
        final uint8List = byteData.buffer.asUint8List();

        await Gal.putImageBytes(
          uint8List,
          album: "Gotchai",
          name: "gotchai_badge_${DateTime.now().millisecondsSinceEpoch}.png",
        );

        if (mounted) {
          CustomToast.showSuccess(context, "이미지를 저장했어요");
        }
      }
    } catch (e) {
      if (mounted) {
        CustomToast.showError(context, e.toString());
      }
    }
  }

  Future<ByteData?> getWidgetImage() async {
    final result = ref.read(testFlowViewModelProvider);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: -2000,
        left: 0,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RepaintBoundary(
              key: _badgeCardKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.horizontalPadding),
                child: BadgeCardWidget(
                  badgeImage: result.testResultData.badgeImage,
                  correctCount: result.testResultData.correctCount,
                  tier: result.testResultData.tier,
                  badgeName: result.testResultData.badgeName,
                  description: result.testResultData.description,
                  isCapturing: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 50));

    final boundary = _badgeCardKey.currentContext!.findRenderObject()!
        as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    overlayEntry.remove();
    return byteData;
  }

  @override
  Widget build(BuildContext context) {
    final test = ref.watch(testViewModelProvider);
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
      NavigationService().navigateClear(NavigationRoute.home);
    }

    void copyPromptToClipboard() async {
      await Clipboard.setData(ClipboardData(text: test.prompt));
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
                SizedBox(height: 112.h),
                BadgeCardWidget(
                  badgeImage: result.testResultData.badgeImage,
                  correctCount: result.testResultData.correctCount,
                  tier: result.testResultData.tier,
                  badgeName: result.testResultData.badgeName,
                  description: result.testResultData.description,
                ),
                SizedBox(height: 24.h),
                BadgeDescriptionCard(
                  theme: test.theme,
                  prompt: test.prompt,
                  iconImage: test.coverImage,
                  onTap: copyPromptToClipboard,
                ),
                SizedBox(
                  height: 150.h,
                )
              ],
            ))),
        Container(
          width: double.infinity,
          height: 112.h,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: getGradientTopColors(result.testResultData.tier),
            stops: [0.0, 1.0],
          )),
          child: Padding(
            padding: EdgeInsets.only(right: 27.w, bottom: 35.h),
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
              height: 162.h,
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
                  padding: EdgeInsets.only(bottom: 56.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 24.w,
                      ),
                      Expanded(
                          child: Button(
                              onTap: saveBadgeCardAsImage,
                              height: 54.h,
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
                        width: 12.w,
                      ),
                      Expanded(
                          child: Button(
                              onTap: () {
                                instagramShare();
                              },
                              height: 54.h,
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
                        width: 24.w,
                      ),
                    ],
                  ))),
        )
      ],
    ));
  }
}
