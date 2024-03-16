import 'package:flutter/material.dart';
import 'package:footloose_app/presentation/ui/auth/login/login_page.dart';
import 'package:footloose_app/presentation/ui/products/product_list/product_list_page.dart';

class AppRoutes {
  static const login = '/login';
  static const productList = '/productList';
}

Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute<void>(
        builder: (_) => const LoginPage(),
      );
    case AppRoutes.productList:
      return MaterialPageRoute<void>(
        builder: (_) => const ProductListPage(),
      );
    default:
      return null;
  }
}

const appInitialRoute = AppRoutes.login;
