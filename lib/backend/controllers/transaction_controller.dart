import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerController {
  final supabase = Supabase.instance.client;

  Future<List<String>> fetchCustomers() async {
    try {
      final response = await supabase.from('pelanggan').select();

      if (response != null) {
        return List<String>.from(
          response.map((customer) => customer['namaPelanggan']),
        );
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching customers: $e');
    }
  }
}

class ProductController {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await supabase
          .from('produk')
          .select();

      if (response != null) {
        return List<Map<String, dynamic>>.from(response);
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
