// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../backend/controllers/routes.dart';
import '../components/donut.dart';
import '../components/cardlist.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductList> foodProducts = [];
  List<ProductList> drinkProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFoodProducts();
    fetchDrinkProducts();
  }

  Future<void> fetchFoodProducts() async {
    final response = await Supabase.instance.client
        .from('produk')
        .select()
        .eq('jenis', 1);

    final data = response as List<dynamic>;
    setState(() {
      foodProducts = data.map((item) {
        return ProductList(
          name: item['namaProduk'],
          stock: item['stok'].toString(),
          price: item['harga'].toString(),
        );
      }).toList();
      isLoading = false;
    });
  }
  Future<void> fetchDrinkProducts() async {
    final response = await Supabase.instance.client
        .from('produk') 
        .select()
        .eq('jenis', 2);

    final data = response as List<dynamic>;
    setState(() {
      drinkProducts = data.map((item) {
        return ProductList(
          name: item['namaProduk'],
          stock: item['stok'].toString(),
          price: item['harga'].toString(),
        );
      }).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SvgPicture.asset(
                    "assets/images/cashier_logo.svg",
                    height: 170,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "PRODUCT",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DonutItem(
                          color: Colors.green,
                          number: isLoading ? 0 : foodProducts.length,
                          label: "Food",
                          iconPath: "assets/icons/food.svg",
                        ),
                        const SizedBox(width: 60),
                        DonutItem(
                          color: Colors.green,
                          number: isLoading ? 0 : drinkProducts.length,
                          label: "Drink",
                          iconPath: "assets/icons/drink.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CardList(
                      title: 'Food',
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, AppRoutes.foodProduct),
                      products: foodProducts,
                    ),
            ),
            SliverToBoxAdapter(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CardList(
                      title: 'Drink',
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, AppRoutes.drinkProduct),
                      products: drinkProducts,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String stock;
  final String price;

  const ProductItem({
    required this.name,
    required this.stock,
    required this.price,
  });
}
