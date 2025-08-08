import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/testflow/test_flow_view_model.dart';

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
        border: Border.all(width: 1, color: Color.fromRGBO(255, 255, 255, 0.2)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Image.network(
            badgeImage,
            width: 100.w,
            height: 100.w,
          ),
          SizedBox(height: 20.h),
          Text(
            correctCount == 7 ? "모두 맞춘 당신은" : "7개중 $correctCount개를 맞춘 당신은",
            style: GotchaiTextStyles.body1.copyWith(
                color: switch (tier) {
              Tier.bronze => GotchaiColorStyles.bronzeText1,
              Tier.silver => GotchaiColorStyles.silverText1,
              Tier.gold => GotchaiColorStyles.goldText1,
              Tier.none => GotchaiColorStyles.gray400,
            }),
          ),
          SizedBox(height: 10.h),
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
          SizedBox(height: 40.h),
          Text(description, style: GotchaiTextStyles.body4),
          SizedBox(height: 60.h),
          Image.asset(
            switch (tier) {
              Tier.bronze => "assets/icon/icon_badge_logo_bronze.png",
              Tier.silver => "assets/icon/icon_badge_logo_silver.png",
              Tier.gold => "assets/icon/icon_badge_logo_gold.png",
              Tier.none => "assets/icon/icon_badge_logo_bronze.png",
            },
            width: 30.w,
            height: 20.w,
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
