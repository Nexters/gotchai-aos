import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/popup/auth_popup.dart';
import 'package:turing/presentation/popup/custom_toast.dart';
import 'package:turing/presentation/setting/setting_view_model.dart';
import 'package:turing/widgets/button.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({
    super.key,
  });

  @override
  ConsumerState<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState<SettingView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(settingViewModelProvider.notifier);

    ref.listen<SettingState>(settingViewModelProvider, (previous, next) {
      if (next is SettingFailure) {
        CustomToast.showError(context, next.message);
      }

      if (next is SettingSuccess) {
        CustomToast.showSuccess(context, next.message);
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
                    onTap: viewModel.navigateToBack,
                    child: Image.asset("assets/icon/icon_back.png",
                        width: Constants.iconSize,
                        height: Constants.iconSize,
                        fit: BoxFit.fill)),
                Text("설정", style: GotchaiTextStyles.body1),
                SizedBox(width: 26.w)
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: GotchaiColorStyles.gray900,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon/icon_ask.png",
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text("문의하기", style: GotchaiTextStyles.body4),
                      Spacer(),
                      Image.asset(
                        "assets/icon/icon_forward.png",
                        width: Constants.iconSize,
                        height: Constants.iconSize,
                      ),
                    ],
                  )),
              onTap: () {
                viewModel.openUrl(UrlType.ask);
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
                child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray900,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon/icon_note.png",
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text("이용약관", style: GotchaiTextStyles.body4),
                        Spacer(),
                        Image.asset(
                          "assets/icon/icon_forward.png",
                          width: Constants.iconSize,
                          height: Constants.iconSize,
                        ),
                      ],
                    )),
                onTap: () {
                  viewModel.openUrl(UrlType.policy);
                }),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
                child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray900,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon/icon_safe.png",
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text("개인정보 처리방침", style: GotchaiTextStyles.body4),
                        Spacer(),
                        Image.asset(
                          "assets/icon/icon_forward.png",
                          width: Constants.iconSize,
                          height: Constants.iconSize,
                        ),
                      ],
                    )),
                onTap: () {
                  viewModel.openUrl(UrlType.security);
                }),
            Spacer(),
            Button(
              onTap: () {
                AuthPopup.showAuthDialog(context, "로그아웃 하시겠어요?", "", "로그아웃",
                    () {
                  Navigator.of(context).pop();
                }, () {
                  viewModel.logout();
                });
              },
              width: double.infinity,
              height: 54.h,
              child: Container(
                width: double.infinity,
                height: 54.h,
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.gray900,
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: Center(
                  child: Text(
                    "로그아웃",
                    style: GotchaiTextStyles.body4,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Button(
              onTap: () {
                AuthPopup.showAuthDialog(context, "정말로 계정을\n탈퇴하시겠어요?",
                    "모든 기록이 사라지며 복구될 수 없어요", "탈퇴하기", () {
                  Navigator.of(context).pop();
                }, () {
                  viewModel.withdrawal();
                });
              },
              width: double.infinity,
              height: 54.h,
              child: Container(
                width: double.infinity,
                height: 54.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "회원탈퇴",
                    style: GotchaiTextStyles.body4
                        .copyWith(color: GotchaiColorStyles.gray200),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}
