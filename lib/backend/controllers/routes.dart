import 'package:flutter/material.dart';
import '../../pages/login.dart';
import '../../pages/home.dart';
import '../../pages/product/foodproduct.dart';
import '../../pages/product/createproductpage.dart';
import '../../pages/product/editproductpage.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String foodProduct = '/foodProduct';
  static const String createProduct = '/createProduct';
  static const String editProduct = '/editProduct';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const Login(),
      home: (context) => const HomePage(),
      foodProduct: (context) => const FoodProductPage(),
      createProduct: (context) => const CreateProductPage(),
      editProduct: (context) => const EditProductPage(),
    };
  }
}