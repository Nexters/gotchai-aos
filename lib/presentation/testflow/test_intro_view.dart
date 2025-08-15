import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/testflow/test_flow_view_model.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestIntroView extends ConsumerWidget {
  const TestIntroView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.watch(testViewModelProvider);

    void navigateToBack() {
      NavigationService().goBackUntil(NavigationRoute.home);
    }

    void navigateToTestFlow() {
      ref.watch(testFlowViewModelProvider.notifier).startTest(test.id);
      NavigationService().navigateWithFade(NavigationRoute.testFlow);
    }

    return Scaffold(
        body: Stack(
      children: [
        Image.network(test.backgroundImage,
            width: double.infinity, height: double.infinity, fit: BoxFit.fill),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(21, 21, 25, 0.5),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.34, 0.52, 0.68, 0.79, 1.0],
              colors: [
                Color.fromRGBO(21, 21, 25, 1.0),
                Color.fromRGBO(21, 21, 25, 0.9),
                Color.fromRGBO(21, 21, 25, 0.6),
                Color.fromRGBO(21, 21, 25, 0),
                Color.fromRGBO(21, 21, 25, 0),
                Color.fromRGBO(21, 21, 25, 1.0),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: Constants.topPadding,
              left: Constants.horizontalPadding,
              right: Constants.horizontalPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Button(
                  onTap: navigateToBack,
                  child: Image.asset("assets/icon/icon_close.png",
                      width: Constants.iconSize,
                      height: Constants.iconSize,
                      fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(test.description, style: GotchaiTextStyles.body1),
              Spacer(),
              Button(
                onTap: navigateToTestFlow,
                width: 345.w,
                height: 57.h,
                child: Container(
                  width: 345.w,
                  height: 57.h,
                  decoration: BoxDecoration(
                    color: GotchaiColorStyles.primary400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "다음",
                      style:
                          GotchaiTextStyles.body2.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
