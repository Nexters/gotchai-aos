import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/home_view_model.dart';
import 'package:turing/presentation/home/widget/home_profile_widget.dart';
import 'package:turing/presentation/mybadge/my_badge_view_model.dart';
import 'package:turing/presentation/mytest/my_solved_test_view_model.dart';
import 'package:turing/presentation/popup/custom_snackbar.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/presentation/home/widget/home_test_widget.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      warmUpProviders();
    });
  }

  void warmUpProviders() {
    ref.read(mySolvedTestViewModelProvider.notifier).getMySolvedTestList();
    ref.read(myBadgeViewModelProvider.notifier).getMyBadgeList();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final testViewModel = ref.watch(testViewModelProvider.notifier);
    final homeState = ref.watch(homeViewModelProvider);

    ref.listen<HomeState>(homeViewModelProvider, (previous, next) {
      if (next is HomeFailure) {
        CustomSnackBar.showError(context, next.message);
      }
    });

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: Constants.topPadding),
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
                              width: 60.w, height: 60.h, fit: BoxFit.fill),
                          Button(
                              child: Image.asset('assets/icon/icon_setting.png',
                                  width: Constants.iconSize,
                                  height: Constants.iconSize,
                                  fit: BoxFit.fill),
                              onTap: () {
                                viewModel.navigateToSetting();
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 80.w,
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
                      height: 30.h,
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      switch (homeState) {
                        HomeInitial() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        HomeLoading() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        HomeLoaded(testList: final testList) => HomeTestWidget(
                            testList: testList,
                            onItemTap: (test) {
                              testViewModel.setCurTestInfo(test);
                              viewModel.navigateToTestFlow();
                            },
                            onRefresh: () async {
                              await viewModel.getExamList();
                            }),
                        HomeFailure(message: final message) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('오류: $message'),
                                ElevatedButton(
                                  onPressed: () => viewModel.getExamList(),
                                  child: Text('다시 시도'),
                                ),
                              ],
                            ),
                          ),
                      },
                      Align(
                          alignment: Alignment.topCenter,
                          child: HomeProfileWidget(
                            onRefresh: () async {},
                            onBadgeForwardTap: viewModel.navigateToMyBadge,
                            onSolvedTestForwardTap:
                                viewModel.navigateToMySolvedTest,
                          ))
                    ])),
                  ],
                ))));
  }
}
