import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/testflow/test_flow_view_model.dart';
import 'package:turing/presentation/home/testflow/test_view_model.dart';
import 'package:turing/presentation/home/testflow/widget/answer_button.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/presentation/popup/test_flow_popup.dart';
import 'package:turing/widgets/button.dart';

class TestFlowView extends ConsumerStatefulWidget {
  const TestFlowView({super.key});

  @override
  ConsumerState<TestFlowView> createState() => _TestFlowViewState();
}

class _TestFlowViewState extends ConsumerState<TestFlowView> {
  @override
  Widget build(BuildContext context) {
    final exam = ref.watch(testViewModelProvider);
    final testFlowViewModel = ref.watch(testFlowViewModelProvider.notifier);
    final state = ref.watch(testFlowViewModelProvider);

    ref.listen<TestFlowState>(testFlowViewModelProvider, (previous, next) {
      if (previous?.curQuizState != next.curQuizState) {
        if (next.curQuizState is CurQuizEnd) {
          final state = next.curQuizState as CurQuizEnd;
          TestFlowPopup.showAnswerDialog(
              context, state.answer ?? "", state.result, () {
            testFlowViewModel.goNext();
            Navigator.of(context).pop();
          });
        }
      }
    });

    void navigateToBack() {
      NavigationService().goBackUntil(NavigationRoute.testCover);
    }

    AnswerButtonType getButtonType(int buttonId) {
      final selectedId = state.curQuizData.selectQuizPick;

      if (selectedId == -1) {
        return AnswerButtonType.none;
      } else if (selectedId == buttonId) {
        return AnswerButtonType.selected;
      } else {
        return AnswerButtonType.unselected;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Image.network(
              exam.backgroundImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120.h, left: 10.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Button(
                    onTap: navigateToBack,
                    child: Image.asset("assets/icon/icon_close.png",
                        width: 12.w, height: 12.w, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  width: double.infinity,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1 - (state.timer / 10000.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: GotchaiColorStyles.primary400,
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  width: 18.w,
                  height: 12.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(191, 255, 0, 0.1),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Text("${state.curIndex}/7",
                      style: GotchaiTextStyles.body5
                          .copyWith(color: GotchaiColorStyles.primary400)),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(state.curQuizData.question,
                    style: GotchaiTextStyles.subtitle2),
                SizedBox(
                  height: 100.h,
                ),
                AnswerButton(
                    width: double.infinity,
                    icon: "assets/icon/icon_A_button.png",
                    text: state.curQuizData.contentAData.content,
                    onTap: () {
                      testFlowViewModel
                          .selectAnswer(state.curQuizData.contentAData.id);
                    },
                    type: getButtonType(state.curQuizData.contentAData.id)),
                SizedBox(
                  height: 40.h,
                ),
                AnswerButton(
                  width: double.infinity,
                  icon: "assets/icon/icon_B_button.png",
                  text: state.curQuizData.contentBData.content,
                  onTap: () {
                    testFlowViewModel
                        .selectAnswer(state.curQuizData.contentBData.id);
                  },
                  type: getButtonType(state.curQuizData.contentBData.id),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
