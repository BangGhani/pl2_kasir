import 'package:flutter/material.dart';
import '../../pages/login.dart';
import '../../pages/home.dart';
import '../../pages/product/foodproduct.dart';
import '../../pages/product/drinkproduct.dart';
import '../../pages/product/createproductpage.dart';
import '../../pages/product/editproductpage.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String foodProduct = '/foodProduct';
  static const String drinkProduct = '/drinkProduct';
  static const String createProduct = '/createProduct';
  static const String editProduct = '/editProduct';

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
      // case editProduct:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => EditProductPage(
      //       productId: args['productId'],
      //       name: args['name'],
      //       stock: args['stock'],
      //       price: args['price'],
      //       type: args['type'],
      //     ),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
