import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/routes/route_name.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/presentation/screens/add_to_cart/add_to_cart_screen.dart';
import 'package:flutter_ecommerce_app/features/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/features/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/dashboard_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider;

import '../../features/presentation/screens/initial/splash_screen.dart';
import '../../features/presentation/viewmodels/product_provider.dart';

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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => DashboardProvider()..fetchAllDataForDashboard(),
            ),
          ],
          child: DashboardScreen(),
        );
      },
    ),
    GoRoute(
      name: RouteName.addToCart,
      path: RouteName.addToCart,
      builder: (context, state) => AddToCartScreen(),
    ),

    GoRoute(
      name: RouteName.productDetails,
      path: RouteName.productDetails,
      builder: (context, state) {
        final productModel = state.extra as ProductModel;
        return ChangeNotifierProvider(
          create: (context) =>
              ProductProvider()..getProductDetailsScreenData(productModel),
          child: ProductDetailScreen(),
        );
      },
    ),
  ];
}
