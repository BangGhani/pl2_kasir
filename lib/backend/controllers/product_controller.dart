import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController {
  // Create a new product
  Future<bool> createProduct(
      String name, int stock, double price, int type) async {
    try {
      final response = await Supabase.instance.client.from('produk').insert([
        {
          'namaProduk': name,
          'stok': stock,
          'harga': price,
          'jenis': type,
        }
      ]).select();

      return true;
    } catch (e) {
      print('Error creating product: $e');
      return false;
    }
  }

  // Delete a product based on produkID
  Future<bool> deleteProduct(int produkID) async {
    try {
      final response = await Supabase.instance.client
          .from('produk')
          .delete()
          .eq('produkID', produkID)
          .select();

      // Check if any product was deleted
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

  // Update a product's details based on produkID
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

      // Check if the update was successful
      if (response.isNotEmpty) {
        return true;
      } else {
        print('No product found with produkID: $produkID');
        return false;
      }
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }
}
