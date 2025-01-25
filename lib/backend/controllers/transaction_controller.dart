import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerController {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchCustomers() async {
    try {
      final response = await supabase.from('pelanggan').select();

      if (response != null) {
        return List<Map<String, dynamic>>.from(response);
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
      final response = await supabase.from('produk').select();

      if (response != null) {
        return List<Map<String, dynamic>>.from(response);
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}

class TransactionController {
  Future<void> addTransaction({
    required pelangganID,
    required int totalHarga,
    required List<Map<String, dynamic>> cartItems,
  }) async {
    try {
      final penjualanResponse =
          await Supabase.instance.client.from('penjualan').insert({
        'tanggalPenjualan': DateTime.now().toIso8601String(),
        'totalHarga': totalHarga,
        'pelangganID': pelangganID,
      }).select(); // Menggunakan .select() untuk mendapatkan response

      final penjualanID = penjualanResponse[0]['penjualanID'];

      final List<Map<String, dynamic>> detailPenjualan = cartItems.map((item) {
        return {
          'penjualanID': penjualanID,
          'produkID': item['produkID'],
          'jumlahProduk': item['total'],
          'subTotal': (item['harga'] as int) * (item['total'] as int),
        };
      }).toList();

      await Supabase.instance.client
          .from('detailpenjualan')
          .insert(detailPenjualan);

      print('Transaction successfully added!');
    } catch (e) {
      print('Error adding transaction: $e');
      rethrow;
    }
  }
}
