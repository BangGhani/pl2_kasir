import 'package:flutter/material.dart';
import '../../pages/login.dart';
import '../../pages/home.dart';
import '../../pages/product/foodproduct.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String foodProduct = '/foodProduct';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const Login(),
      home: (context) => const HomePage(),
      foodProduct: (context) => const FoodProduct(),
    };
  }
}