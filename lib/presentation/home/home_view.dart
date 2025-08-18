import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/home_view_model.dart';
import 'package:turing/presentation/home/widget/home_profile_widget.dart';
import 'package:turing/presentation/home/widget/home_test_widget.dart';
import 'package:turing/presentation/popup/custom_snackbar.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/widgets/button.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final testViewModel = ref.watch(testViewModelProvider.notifier);
    final homeState = ref.watch(homeViewModelProvider);

    ref.listen<HomesState>(homeViewModelProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        CustomSnackBar.showError(context, next.errorMessage);
      }
    });

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 56.h),
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/icon/gotchai_logo.png',
                              width: 124.w, height: 38.h, fit: BoxFit.fill),
                          Button(
                              child: Image.asset('assets/icon/icon_setting.png',
                                  width: 26.w, height: 26.w, fit: BoxFit.fill),
                              onTap: () {
                                viewModel.navigateToSetting();
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 200.w,
                          child: TabBar(
                            dividerHeight: 0,
                            labelColor: GotchaiColorStyles.primary400,
                            unselectedLabelColor: GotchaiColorStyles.gray600,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: GotchaiColorStyles.primary400,
                            labelStyle: GotchaiTextStyles.body2,
                            unselectedLabelStyle: GotchaiTextStyles.body2,
                            tabs: const [
                              Tab(
                                text: '테스트',
                              ),
                              Tab(text: '내 업적'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      HomeTestWidget(
                          testList: homeState.testList,
                          onItemTap: (test) {
                            testViewModel.setCurTestInfo(test);
                            viewModel.navigateToTestFlow();
                          },
                          onRefresh: () async {
                            await viewModel.getExamList();
                          }),
                      Align(
                          alignment: Alignment.topCenter,
                          child: HomeProfileWidget(
                            onRefresh: () async {},
                            onBadgeForwardTap: viewModel.navigateToMyBadge,
                            onSolvedTestForwardTap:
                                viewModel.navigateToMySolvedTest,
                            rating: homeState.ranking,
                            name: homeState.name,
                            recentBadge: homeState.recentBadge,
                          ))
                    ])),
                  ],
                ))));
  }
}
