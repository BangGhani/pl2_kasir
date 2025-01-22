import 'package:flutter/material.dart';
import '../../pages/login.dart';
import '../../pages/home.dart';
import '../../pages/product/foodproduct.dart';
import '../../pages/product/drinkproduct.dart';
import '../../pages/transaction/invoice.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String foodProduct = '/foodProduct';
  static const String drinkProduct = '/drinkProduct';
  static const String invoice = '/invoice';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case foodProduct:
        return MaterialPageRoute(builder: (_) => const FoodProductPage());
      case drinkProduct:
        return MaterialPageRoute(builder: (_) => const DrinkProductPage());
      case invoice:
        return MaterialPageRoute(builder: (_) => const InvoicePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
