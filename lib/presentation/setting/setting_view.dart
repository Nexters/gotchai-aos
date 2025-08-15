import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/presentation/popup/auth_popup.dart';
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

  void navigateToBack() {
    NavigationService().goBack();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(settingViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Constants.topPadding,
            left: Constants.horizontalPadding,
            right: Constants.horizontalPadding),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Button(
                onTap: navigateToBack,
                child: Image.asset("assets/icon/icon_back.png",
                    width: Constants.iconSize,
                    height: Constants.iconSize,
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.gray900,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/icon_ask.png",
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text("문의하기", style: GotchaiTextStyles.body4),
                    Spacer(),
                    Button(
                        child: Image.asset(
                          "assets/icon/icon_forward.png",
                          width: Constants.iconSize,
                          height: Constants.iconSize,
                        ),
                        onTap: () {})
                  ],
                )),
            SizedBox(
              height: 20.h,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.gray900,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/icon_note.png",
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text("이용약관", style: GotchaiTextStyles.body4),
                    Spacer(),
                    Button(
                        child: Image.asset(
                          "assets/icon/icon_forward.png",
                          width: Constants.iconSize,
                          height: Constants.iconSize,
                        ),
                        onTap: () {})
                  ],
                )),
            SizedBox(
              height: 20.h,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.gray900,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/icon_safe.png",
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text("개인정보 처리방침", style: GotchaiTextStyles.body4),
                    Spacer(),
                    Button(
                        child: Image.asset(
                          "assets/icon/icon_forward.png",
                          width: Constants.iconSize,
                          height: Constants.iconSize,
                        ),
                        onTap: () {})
                  ],
                )),
            Spacer(),
            SizedBox(
              height: 80.h,
            ),
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
              height: 120.h,
              child: Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.gray900,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "로그아웃",
                    style: GotchaiTextStyles.body2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Button(
              onTap: () {
                AuthPopup.showAuthDialog(context, "정말로 계정을\n탈퇴하시겠어요?",
                    "모든 기록이 사라지며 복구될 수 없어요", "탈퇴하기", () {
                  Navigator.of(context).pop();
                }, () {
                  // 탈퇴처리
                });
              },
              width: double.infinity,
              height: 120.h,
              child: Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "회원탈퇴",
                    style: GotchaiTextStyles.body3
                        .copyWith(color: GotchaiColorStyles.gray200),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120.h,
            )
          ],
        ),
      ),
    );
  }
}
