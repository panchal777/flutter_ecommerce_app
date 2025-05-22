import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/routes/route_name.dart';
import 'package:flutter_ecommerce_app/features/presentation/screens/add_to_cart/add_to_cart_screen.dart';
import 'package:flutter_ecommerce_app/features/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/dashboard_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;

import '../../features/presentation/screens/initial/splash_screen.dart';

class AppRouter {
  AppRouter._();

  /// Key so we can navigate without context.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /*----------------------------------------*/

  static GoRouter? _baseRoutes;

  static GoRouter get baseRouters => _baseRoutes!;

  static List<GoRoute> get routes => _routes;

  static void init() {
    _baseRoutes = GoRouter(
      initialLocation: '/',
      navigatorKey: navigatorKey,
      routes: <GoRoute>[...routes],
      redirect: (context, state) {
        return null;
      },
    );
  }

  static final _routes = <GoRoute>[
    GoRoute(
      path: RouteName.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: RouteName.dashboard,
      path: RouteName.dashboard,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) => DashboardProvider()..fetchAllDataForDashboard(),
          child: DashboardScreen(),
        );
      },
    ),
    GoRoute(
      name: RouteName.addToCart,
      path: RouteName.addToCart,
      builder: (context, state) => AddToCartScreen(),
    ),
  ];
}
