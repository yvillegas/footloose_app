import 'package:flutter/material.dart';
import 'package:footloose_app/presentation/ui/auth/login/login_page.dart';

class AppRoutes {
  static const login = '/login';
}

Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute<void>(
        builder: (_) => const LoginPage(),
      );
    default:
      return null;
  }
}

const appInitialRoute = AppRoutes.login;
