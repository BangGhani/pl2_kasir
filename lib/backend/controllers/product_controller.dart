import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController {
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await Supabase.instance.client.from('produk').select();
      return response;
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }

  Future<bool> createProduct(String name, int stock, double price, int type) async {
    try {
      final response = await Supabase.instance.client.from('produk').insert([
        {
          'namaProduk': name,
          'stok': stock,
          'harga': price,
          'jenis': type,
        }
      ]).select();
      if (response.isNotEmpty) {
        return true;
      } else {
        print('Failed to add product');
        return false;
      }
    } catch (e) {
      print('Error creating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(int produkID) async {
    try {
      final response = await Supabase.instance.client
          .from('produk')
          .delete()
          .eq('produkID', produkID)
          .select();

      if (response.isNotEmpty) {
        return true;
      } else {
        print('No product found with produkID: $produkID');
        return false;
      }
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  Future<bool> updateProduct(
      int produkID, String name, int stock, double price, int type) async {
    try {
      final response = await Supabase.instance.client
          .from('produk')
          .update({
            'namaProduk': name,
            'stok': stock,
            'harga': price,
            'jenis': type,
          })
          .eq('produkID', produkID)
          .select();

      if (response.isNotEmpty) {
        return true;
      } else {
        print('No product found with name: $name');
        return false;
      }
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }
}
