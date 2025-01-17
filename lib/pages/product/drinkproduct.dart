// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../backend/controllers/routes.dart';
import '../../backend/controllers/product_controller.dart';
import '../components/cardlistdetail.dart';
import '../components/bottombutton.dart';
import 'editproductpage.dart';
import 'createproductpage.dart';

class DrinkProductPage extends StatefulWidget {
  const DrinkProductPage({super.key});

  @override
  _DrinkProductPageState createState() => _DrinkProductPageState();
}

class _DrinkProductPageState extends State<DrinkProductPage> {
  List<ProductList> drinkProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDrinkProducts();
  }

  Future<void> fetchDrinkProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('produk')
          .select('produkID, namaProduk, stok, harga')
          .eq('jenis', 2);

      final data = response as List<dynamic>;

      setState(() {
        drinkProducts = data.map((item) {
          return ProductList(
            id: item['produkID'],
            name: item['namaProduk'],
            stock: item['stok'].toString(),
            price: item['harga'].toString(),
            edit: () {
              EditProductDialog.showEditProductDialog(
                context,
                productId: item['produkID'],
                name: item['namaProduk'],
                stock: item['stok'],
                price: item['harga'],
                type: item['jenis'] ?? 2,
              ).then((_) {
                fetchDrinkProducts();
              });
            },
            delete: () {
              _deleteProduct(item['produkID']);
            },
          );
        }).toList();

        drinkProducts.sort((a, b) => a.name.compareTo(b.name));

        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching products: $error')),
      );
    }
  }

  Future<void> _deleteProduct(int produkID) async {
    ProductController productController = ProductController();
    bool success = await productController.deleteProduct(produkID);

    if (success) {
      // Refresh the list after deleting
      fetchDrinkProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Drink Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CardList(
                      products: drinkProducts,
                    ),
            ),
            GreenButton(
              text: 'Add Product',
              onPressed: () {
                CreateProductPage.createProduct(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
