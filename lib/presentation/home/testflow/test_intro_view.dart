import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/testflow/test_view_model.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestIntroView extends ConsumerWidget {
  const TestIntroView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = ref.watch(testViewModelProvider);

    void navigateToBack() {
      NavigationService().goBack();
    }

    return Scaffold(
        body: Stack(
      children: [
        Image.network(exam.backgroundImage,
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
              stops: [0.0, 0.48, 0.68, 0.79, 1.0],
              colors: [
                Color.fromRGBO(21, 21, 25, 1.0),
                Color.fromRGBO(21, 21, 25, 0.9),
                Color.fromRGBO(21, 21, 25, 0),
                Color.fromRGBO(21, 21, 25, 0),
                Color.fromRGBO(21, 21, 25, 1.0),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 100.h, left: 10.w, right: 10.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Button(
                  onTap: navigateToBack,
                  child: Image.asset("assets/icon/icon_close.png",
                      width: 20.w, height: 20.w, fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Text(exam.description, style: GotchaiTextStyles.body1),
              Spacer(),
              Button(
                onTap: () {},
                width: double.infinity,
                height: 120.h,
                child: Container(
                  width: double.infinity,
                  height: 120.h,
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
                height: 120.h,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
