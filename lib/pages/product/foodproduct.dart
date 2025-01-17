// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../backend/controllers/routes.dart';
import '../../backend/controllers/product_controller.dart';
import '../components/cardlistdetail.dart';
import '../components/bottombutton.dart';
import 'createproductpage.dart';
import 'editproductpage.dart';

class FoodProductPage extends StatefulWidget {
  const FoodProductPage({super.key});

  @override
  _FoodProductPageState createState() => _FoodProductPageState();
}

class _FoodProductPageState extends State<FoodProductPage> {
  List<ProductList> foodProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFoodProducts();
  }

  Future<void> fetchFoodProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('produk')
          .select('produkID, namaProduk, stok, harga')
          .eq('jenis', 1);

      final data = response as List<dynamic>;

      setState(() {
        foodProducts = data.map((item) {
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
                type: item['jenis'] ?? 1,
              ).then((_) {
                fetchFoodProducts();
              });
            },
            delete: () {
              _deleteProduct(item['produkID']);
            },
          );
        }).toList();

        // Sorting berdasarkan namaProduk dari kecil ke besar
        foodProducts.sort((a, b) => a.name.compareTo(b.name));

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
      fetchFoodProducts();
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
          'Food Products',
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
                      products: foodProducts,
                    ),
            ),
            GreenButton(
              text: 'Add Product',
              onPressed: () async {
                bool result = await CreateProductPage.createProduct(context);
                if (result) {
                  fetchFoodProducts();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
