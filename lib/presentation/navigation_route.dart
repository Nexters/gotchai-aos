import 'package:flutter/material.dart';
import 'package:turing/presentation/home/home_view.dart';
import 'package:turing/presentation/login/login_view.dart';

class NavigationRoute {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    home: (context) => const HomeView(),
  };
}
