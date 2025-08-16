import 'package:flutter/material.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/date_util.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/widgets/button.dart';

class HomeProfileWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final VoidCallback onBadgeForwardTap;
  final VoidCallback onSolvedTestForwardTap;
  final String name;
  final int rating;
  final MyBadgeItem recentBadge;

  const HomeProfileWidget({
    super.key,
    required this.onRefresh,
    required this.onBadgeForwardTap,
    required this.onSolvedTestForwardTap,
    required this.name,
    required this.rating,
    required this.recentBadge,
  });

  String _getRankingImagePath(int rating) {
    if (rating >= 50) return "assets/image/image_ranking50.png";
    if (rating >= 25) return "assets/image/image_ranking25.png";
    if (rating >= 10) return "assets/image/image_ranking10.png";
    return "assets/image/image_ranking5.png";
  }

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
                SizedBox(height: 8.h),
                ClipOval(
                  child: Image.network(
                    "",
                    width: 108.w,
                    height: 108.w,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/icon/icon_empty_profile.png',
                        width: 108.w,
                        height: 108.w,
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 36.h,
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
                      name,
                      style: GotchaiTextStyles.body4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          _getRankingImagePath(rating),
                          width: double.infinity,
                          height: 160.h,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                        left: 20.w,
                        top: 20.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$name님은",
                                style: GotchaiTextStyles.body6.copyWith(
                                    color: Color.fromRGBO(255, 255, 255, 0.6))),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "상위 $rating%",
                              style: GotchaiTextStyles.subtitle2,
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                    padding: EdgeInsets.all(20.w),
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
                              width: 8.w,
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
                        recentBadge.id == -1
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 8.h,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(recentBadge.name,
                                              style: GotchaiTextStyles.body2),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                              "${DateUtil.formatToMonthDay(recentBadge.acquiredAt)}에 획득",
                                              style: GotchaiTextStyles.body4
                                                  .copyWith(
                                                      color: GotchaiColorStyles
                                                          .gray500))
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                          padding: EdgeInsets.all(4.w),
                                          width: 100.w,
                                          height: 100.w,
                                          decoration: BoxDecoration(
                                            color: GotchaiColorStyles.gray800,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.network(
                                            recentBadge.image,
                                            width: 100.w,
                                            height: 100.w,
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/icon/icon_empty_graphic.png',
                                                width: 80.w,
                                                height: 80.w,
                                              );
                                            },
                                          ))
                                    ],
                                  )
                                ],
                              )
                      ],
                    )),
                SizedBox(height: 12.h),
                Container(
                    padding: EdgeInsets.all(20.w),
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
                          width: 8.w,
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
