import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/presentation/mybadge/my_badge_view_model.dart';
import 'package:turing/presentation/popup/custom_snackbar.dart';
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

    ref.listen<MyBadgeState>(myBadgeViewModelProvider, (previous, next) {
      if (next is MyBadgeFailure) {
        CustomSnackBar.showError(context, next.message);
      }
    });

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
          switch (state) {
            MyBadgeInitial() => SizedBox.shrink(),
            MyBadgeLoading() => Center(child: CircularProgressIndicator()),
            MybadgeLoaded() => Expanded(
                  child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    state.badges.isEmpty
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
                                    Text("축하해요",
                                        style: GotchaiTextStyles.body6),
                                    Text("${state.badges.length}개의 배지를 모았어요!",
                                        style: GotchaiTextStyles.body2.copyWith(
                                            color:
                                                GotchaiColorStyles.primary400))
                                  ],
                                )
                              ],
                            )),
                    SizedBox(height: 20.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.badges.length,
                      itemBuilder: (context, index) {
                        final badge = state.badges[index];
                        return _buildBadgeItem(badge);
                      },
                    ),
                    SizedBox(height: 120.h),
                  ],
                ),
              )),
            MyBadgeFailure() => Center(child: Text("Error"))
          },
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
