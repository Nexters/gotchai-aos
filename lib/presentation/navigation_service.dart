import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._internal();

  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic>? navigateClear(Widget page) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  Future<dynamic>? navigateClearWithSlide(Widget page) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      _createSlideRoute(page),
      (route) => false,
    );
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

  Future<dynamic>? navigateWithSlide(Widget page) {
    return navigatorKey.currentState?.push(_createSlideRoute(page));
  }

  Route _createSlideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // 오른쪽에서 왼쪽
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
