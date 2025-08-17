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
          top: 56.h,
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
              SizedBox(width: 26.w)
            ],
          ),
          SizedBox(height: 10.h),
          switch (state) {
            MyBadgeInitial() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            MyBadgeLoading() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            MyBadgeLoaded() => Expanded(
                  child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: state.badges.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 370.h,
                          ),
                          Text(
                            "취득 가능한 뱃지가 없습니다",
                            style: GotchaiTextStyles.body3
                                .copyWith(color: GotchaiColorStyles.gray500),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: 10.h),
                          state.badges.isEmpty
                              ? SizedBox.shrink()
                              : Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: GotchaiColorStyles.primary900,
                                    borderRadius: BorderRadius.circular(16.w),
                                  ),
                                  padding: EdgeInsets.all(20.w),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/icon_party.png",
                                        width: 42.w,
                                        height: 42.w,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 12.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("축하해요",
                                              style: GotchaiTextStyles.body6),
                                          Text(
                                              "${state.badges.length}개의 배지를 모았어요!",
                                              style: GotchaiTextStyles.body2
                                                  .copyWith(
                                                      color: GotchaiColorStyles
                                                          .primary400))
                                        ],
                                      )
                                    ],
                                  )),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
            width: 104.w,
            height: 104.w,
            decoration: BoxDecoration(
              color: GotchaiColorStyles.gray900,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: badge.id == -1
                ? Center(
                    child: Image.asset(
                      'assets/icon/icon_questionmark.png',
                      width: 60.w,
                      height: 60.w,
                    ),
                  )
                : Center(
                    child: Image.network(
                    badge.image,
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/icon/icon_empty_graphic.png',
                        width: 80.w,
                        height: 80.w,
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
