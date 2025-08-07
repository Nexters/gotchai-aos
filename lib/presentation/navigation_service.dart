import 'package:flutter/material.dart';
import 'package:turing/presentation/navigation_route.dart';

class NavigationService {
  NavigationService._internal();

  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Widget? getPageByRouteName(String routeName) {
    final widgetBuilder = NavigationRoute.routes[routeName];
    if (widgetBuilder != null) {
      final context = navigatorKey.currentContext;
      if (context != null) {
        return widgetBuilder(context);
      }
    }
    return null;
  }

  Future<dynamic>? navigateClear(String routeName) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  Future<dynamic>? navigateClearWithSlide(String routeName) {
    final page = getPageByRouteName(routeName);
    if (page != null) {
      return navigatorKey.currentState?.pushAndRemoveUntil(
        _createSlideRoute(page, routeName: routeName),
        (route) => false,
      );
    }
    return null;
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

  void goBackUntil(String routeName) {
    navigatorKey.currentState?.popUntil((route) {
      return route.settings.name == routeName || route.isFirst;
    });
  }

  Future<dynamic>? navigateWithSlide(String routeName) {
    final page = getPageByRouteName(routeName);
    if (page != null) {
      return navigatorKey.currentState?.push(
        _createSlideRoute(page, routeName: routeName),
      );
    }
    return null;
  }

  Future<dynamic>? navigateWithFade(String routeName) {
    final page = getPageByRouteName(routeName);
    if (page != null) {
      return navigatorKey.currentState?.push(
        _createFadeRoute(page, routeName: routeName),
      );
    }
    return null;
  }

  Route _createFadeRoute(Widget page, {String? routeName}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        final fadeAnimation = animation.drive(
          Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve)),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 100),
    );
  }

  Route _createSlideRoute(Widget page, {String? routeName}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
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
