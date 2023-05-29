// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/pages/dashboard_page.dart';
import 'package:food_recipes_flutter/pages/favorite_page.dart';
import 'package:food_recipes_flutter/pages/login_page.dart';
import 'package:food_recipes_flutter/pages/splash_page.dart';

class AppRoute {
  static const String SPLASH_PAGE = "/splash";
  static const String LOGIN_PAGE = "/login";
  static const String DASHBOARD_PAGE = "/dashboard";
  static const String FAVORITE_PAGE = "/favorite";

  static Map<String, Widget Function(BuildContext)> allRoutes(
      BuildContext context) {
    return {
      SPLASH_PAGE: (context) => const SplashPage(),
      LOGIN_PAGE: (context) => const LoginPage(),
      DASHBOARD_PAGE: (context) => const DashboardPage(),
      FAVORITE_PAGE: (context) => const FavoritePage(),
    };
  }
}
