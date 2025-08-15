import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/testflow/test_flow_view_model.dart';

class BadgeCardWidget extends StatelessWidget {
  final String badgeImage;
  final int correctCount;
  final Tier tier;
  final String badgeName;
  final String description;

  const BadgeCardWidget({
    super.key,
    required this.badgeImage,
    required this.correctCount,
    required this.tier,
    required this.badgeName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(width: 1, color: Color.fromRGBO(255, 255, 255, 0.2)),
        ),
        child: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: switch (tier) {
                      Tier.bronze => [
                          GotchaiColorStyles.bronzeLinear1,
                          GotchaiColorStyles.bronzeLinear2,
                        ],
                      Tier.silver => [
                          GotchaiColorStyles.silverLinear1,
                          GotchaiColorStyles.silverLinear2,
                        ],
                      Tier.gold => [
                          GotchaiColorStyles.goldLinear1,
                          GotchaiColorStyles.goldLinear2,
                        ],
                      Tier.none => [
                          GotchaiColorStyles.gray700,
                          GotchaiColorStyles.gray900,
                        ],
                    },
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: Opacity(
                  opacity: 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: RadialGradient(
                        center: Alignment.bottomCenter,
                        radius: 1.5,
                        colors: switch (tier) {
                          Tier.bronze => [
                              GotchaiColorStyles.bronzeRadial1,
                              GotchaiColorStyles.bronzeRadial2,
                              GotchaiColorStyles.bronzeRadial3,
                            ],
                          Tier.silver => [
                              GotchaiColorStyles.silverRadial1,
                              GotchaiColorStyles.silverRadial2,
                              GotchaiColorStyles.silverRadial3,
                            ],
                          Tier.gold => [
                              GotchaiColorStyles.goldRadial1,
                              GotchaiColorStyles.goldRadial2,
                              GotchaiColorStyles.goldRadial3,
                            ],
                          Tier.none => [
                              GotchaiColorStyles.gray700,
                              GotchaiColorStyles.gray900,
                              GotchaiColorStyles.gray900,
                            ],
                        },
                        stops: const [0.0, 0.3, 0.5],
                      ),
                    ),
                  ))),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 27.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.h,
                    ),
                    Image.network(
                      badgeImage,
                      width: 212.w,
                      height: 212.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      correctCount == 7
                          ? "모두 맞춘 당신은"
                          : "7개중 $correctCount개를 맞춘 당신은",
                      style: GotchaiTextStyles.body1.copyWith(
                          color: switch (tier) {
                        Tier.bronze => GotchaiColorStyles.bronzeText1,
                        Tier.silver => GotchaiColorStyles.silverText1,
                        Tier.gold => GotchaiColorStyles.goldText1,
                        Tier.none => GotchaiColorStyles.gray400,
                      }),
                    ),
                    Text(
                      badgeName,
                      style: GotchaiTextStyles.title3.copyWith(
                          color: switch (tier) {
                        Tier.bronze => GotchaiColorStyles.bronzeText2,
                        Tier.silver => GotchaiColorStyles.silverText2,
                        Tier.gold => GotchaiColorStyles.goldText2,
                        Tier.none => GotchaiColorStyles.gray400,
                      }),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      description,
                      style: GotchaiTextStyles.body4,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                    Image.asset(
                      switch (tier) {
                        Tier.bronze => "assets/icon/icon_badge_logo_bronze.png",
                        Tier.silver => "assets/icon/icon_badge_logo_silver.png",
                        Tier.gold => "assets/icon/icon_badge_logo_gold.png",
                        Tier.none => "assets/icon/icon_badge_logo_bronze.png",
                      },
                      width: 56.w,
                      height: 12.h,
                    ),
                  ],
                ),
              ))
        ]));
  }
}
