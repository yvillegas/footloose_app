import 'package:flutter/material.dart';
import 'package:footloose_app/injection/injection.dart';
import 'package:footloose_app/presentation/routes/app_routes.dart';

void main() async {
  await init();
  runApp(const FootlooseApp());
}

class FootlooseApp extends StatelessWidget {
  const FootlooseApp({super.key});

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
