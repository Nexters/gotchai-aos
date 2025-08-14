import 'package:flutter/material.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/widgets/button.dart';

class HomeProfileWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final VoidCallback onBadgeForwardTap;
  final VoidCallback onSolvedTestForwardTap;

  const HomeProfileWidget({
    super.key,
    required this.onRefresh,
    required this.onBadgeForwardTap,
    required this.onSolvedTestForwardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          color: GotchaiColorStyles.primary400,
          backgroundColor: GotchaiColorStyles.gray800,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                ClipOval(
                  child: Image.network(
                    "",
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/icon/icon_empty_graphic.png',
                        width: 50.w,
                        height: 50.w,
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  width: 40.w,
                  height: 80.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E2803),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: GotchaiColorStyles.primary600,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "갓챠135",
                    style: GotchaiTextStyles.body4,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/image/image_ranking5.png",
                          width: double.infinity,
                          height: 350.h,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                        left: 10.w,
                        top: 10.w,
                        child: Column(
                          children: [
                            Text("갓챠135님은",
                                style: GotchaiTextStyles.body6.copyWith(
                                    color: Color.fromRGBO(255, 255, 255, 0.6))),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("상위 5%", style: GotchaiTextStyles.subtitle2),
                          ],
                        )),
                  ],
                ),
                SizedBox(height: 30.h),
                Container(
                    padding: EdgeInsets.all(10.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/icon_badge.png',
                              width: Constants.iconSize,
                              height: Constants.iconSize,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text("내 배지", style: GotchaiTextStyles.body2),
                            Spacer(),
                            Button(
                                onTap: onBadgeForwardTap,
                                child: Image.asset(
                                  "assets/icon/icon_forward.png",
                                  width: Constants.iconSize,
                                  height: Constants.iconSize,
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          color: Color.fromRGBO(118, 120, 128, 0.4),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("기계사냥꾼", style: GotchaiTextStyles.body2),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("7월 18일에 획득",
                                    style: GotchaiTextStyles.body4.copyWith(
                                        color: GotchaiColorStyles.gray500))
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(4.w),
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: GotchaiColorStyles.gray800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                "assets/icon/icon_badge.png",
                                width: 20.w,
                                height: 20.w,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(height: 30.h),
                Container(
                    padding: EdgeInsets.all(10.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon/icon_history.png",
                          width: Constants.iconSize,
                          height: Constants.iconSize,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text("내가 풀었던 테스트", style: GotchaiTextStyles.body2),
                        Spacer(),
                        Button(
                            onTap: onSolvedTestForwardTap,
                            child: Image.asset(
                              "assets/icon/icon_forward.png",
                              width: Constants.iconSize,
                              height: Constants.iconSize,
                              fit: BoxFit.fill,
                            ))
                      ],
                    )),
                SizedBox(height: 150.h),
              ],
            ),
          ),
        ));
  }
}
