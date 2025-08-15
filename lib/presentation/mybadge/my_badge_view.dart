import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/presentation/mybadge/my_badge_view_model.dart';
import 'package:turing/widgets/button.dart';

class MyBadgeView extends ConsumerStatefulWidget {
  const MyBadgeView({
    super.key,
  });

  @override
  ConsumerState<MyBadgeView> createState() => _MyBadgeViewState();
}

class _MyBadgeViewState extends ConsumerState<MyBadgeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myBadgeViewModelProvider.notifier).getMyBadgeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myBadgeViewModelProvider);
    final viewModel = ref.read(myBadgeViewModelProvider.notifier);

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
                  onTap: () {
                    viewModel.navigateToback();
                  }),
              Text("내 배지", style: GotchaiTextStyles.body1),
              SizedBox(width: 12.w)
            ],
          ),
          SizedBox(height: 40.h),
          Expanded(
              child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                state.isEmpty
                    ? SizedBox.shrink()
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: GotchaiColorStyles.primary900,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/icon_party.png",
                              width: 20.w,
                              height: 20.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("축하해요", style: GotchaiTextStyles.body6),
                                Text("${state.length}개의 배지를 모았어요!",
                                    style: GotchaiTextStyles.body2.copyWith(
                                        color: GotchaiColorStyles.primary400))
                              ],
                            )
                          ],
                        )),
                SizedBox(height: 20.h),
                state.isEmpty
                    ? Center(
                        child: Text(
                          "아직 획득한 배지가 없어요",
                          style: GotchaiTextStyles.body3
                              .copyWith(color: GotchaiColorStyles.gray500),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          final badge = state[index];
                          return _buildBadgeItem(badge);
                        },
                      ),
                SizedBox(height: 120.h),
              ],
            ),
          )),
        ],
      ),
    ));
  }

  Widget _buildBadgeItem(MyBadgeItem badge) {
    return Column(
      children: [
        Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: GotchaiColorStyles.gray800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: badge.id == -1
                ? Center(
                    // Center로 감싸기
                    child: Image.asset(
                      'assets/icon/icon_questionmark.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                  )
                : Center(
                    child: Image.network(
                    badge.image,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/icon/icon_empty_graphic.png',
                        width: 20.w,
                        height: 20.w,
                      );
                    },
                  ))),
        SizedBox(height: 10.h),
        Text(
          badge.name,
          style: GotchaiTextStyles.body6,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
