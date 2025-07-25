import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_exito/core/config/di/di_manager.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/categories_page.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/product/product_page.dart';
import 'package:group_exito/ui/feature/not_found/not_found_page.dart';
import 'package:group_exito/ui/feature/splash/presentation/page/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: DIManager.getNavKey(),
    initialLocation: SplashPage.routeName,
    routes: <RouteBase>[
      GoRoute(path: SplashPage.routeName, builder: (BuildContext context, GoRouterState state) => const SplashPage()),
      GoRoute(path: CategoriesPage.routeName, builder: (BuildContext context, GoRouterState state) => const CategoriesPage()),
      GoRoute(
        path: '/product/:id',
        name: ProductPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          final int categoryId = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return ProductPage(categoryId: categoryId);
        },
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) => const NotFoundPage(),
  );
}
