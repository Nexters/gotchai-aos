import 'package:flutter/material.dart';
import 'package:turing/presentation/home/home_view.dart';
import 'package:turing/presentation/home/testflow/test_cover_view.dart';
import 'package:turing/presentation/home/testflow/test_intro_view.dart';
import 'package:turing/presentation/login/login_view.dart';
import 'package:turing/presentation/onboarding/onboarding_view.dart';

class NavigationRoute {
  static const String login = '/login';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String testIntro = '/testIntro';
  static const String testCover = '/testCover';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    home: (context) => const HomeView(),
    onboarding: (context) => const OnboardingView(),
    testIntro: (context) => const TestIntroView(),
    testCover: (context) => const TestCoverView(),
  };
}
