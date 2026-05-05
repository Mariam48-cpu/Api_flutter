import 'package:ecommerce_app_api_26/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_api_26/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}
