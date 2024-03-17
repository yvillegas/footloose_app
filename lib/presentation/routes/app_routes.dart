import 'package:flutter/material.dart';
import 'package:footloose_app/presentation/ui/auth/login/login_page.dart';
import 'package:footloose_app/presentation/ui/products/product_detail/product_detail_page.dart';
import 'package:footloose_app/presentation/ui/products/product_list/product_list_page.dart';
import 'package:footloose_app/presentation/ui/shopping_cart/shopping_cart_page.dart';

class AppRoutes {
  static const login = '/login';
  static const productList = '/productList';
  static const productDetail = '/productDetail';
  static const shoppingCart = '/shoppingCart';
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
    case AppRoutes.productDetail:
      final arguments = settings.arguments as ProductDetailPageArguments?;
      return MaterialPageRoute<void>(
        builder: (_) => ProductDetailPage(
          id: arguments!.productoId,
        ),
      );
    case AppRoutes.shoppingCart:
      return MaterialPageRoute<void>(
        builder: (_) => const ShoppingCartPage(),
      );
    default:
      return null;
  }
}

const appInitialRoute = AppRoutes.login;
