import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/use_cases/save_shopping_cart.dart';
import 'package:footloose_app/injection/injection.dart';
import 'package:footloose_app/presentation/blocs/shopping_cart/shopping_cart_bloc.dart';
import 'package:footloose_app/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp();
  runApp(const FootlooseApp());
}

class FootlooseApp extends StatelessWidget {
  const FootlooseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCartBloc(
        saveShoppingCart: getIt<SaveShoppingCart>(),
      ),
      child: const Init(),
    );
  }
}

class Init extends StatelessWidget {
  const Init({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Footloose App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
      initialRoute: appInitialRoute,
    );
  }
}
