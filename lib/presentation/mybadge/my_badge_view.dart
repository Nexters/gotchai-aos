import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/mybadge/my_badge_view_model.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/widgets/button.dart';

class MyBadgeView extends ConsumerWidget {
  const MyBadgeView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myBadgeViewModelProvider);
    final test = ref.watch(testViewModelProvider);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          top: Constants.topPadding,
          left: Constants.horizontalPadding,
          right: Constants.horizontalPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                  child: Image.asset("assets/icon/icon_back.png",
                      width: Constants.iconSize,
                      height: Constants.iconSize,
                      fit: BoxFit.fill),
                  onTap: () {}),
              Text("내 배지", style: GotchaiTextStyles.body1),
              SizedBox(
                width: 12.w,
              )
            ],
          ),
          SizedBox(
            height: 80.h,
          ),
          Spacer(),
          SizedBox(
            height: 120.h,
          ),
        ],
      ),
    ));
  }
}
