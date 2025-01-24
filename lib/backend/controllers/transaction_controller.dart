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
  var supabase = Supabase.instance.client;

  TransactionController(this.supabase);

  Future<void> addTransaction({
    required String pelangganID,
    required int totalHarga,
    required List<Map<String, dynamic>> cartItems,
  }) async {
    try {
      // Step 1: Insert into 'penjualan' table
      final penjualanResponse = await supabase
          .from('penjualan')
          .insert({
            'tanggalPenjualan': DateTime.now().toIso8601String(),
            'totalHarga': totalHarga,
            'pelangganID': pelangganID,
          })
          .select('penjualanID')
          .single();

      if (penjualanResponse == null ||
          penjualanResponse['penjualanID'] == null) {
        throw Exception('Failed to insert transaction into penjualan table.');
      }

      final penjualanID = penjualanResponse['penjualanID'];

      // Step 2: Insert into 'detailPenjualan' table
      final List<Map<String, dynamic>> detailPenjualanData =
          cartItems.map((item) {
        return {
          'penjualanID': penjualanID,
          'produkID': item['produkID'], // Assuming this key exists in cartItems
          'jumlahProduk': item['total'], // From cartItems[index]['total']
          'subTotal': (item['harga'] as int) * (item['total'] as int),
        };
      }).toList();

      final detailResponse =
          await supabase.from('detailPenjualan').insert(detailPenjualanData);

      if (detailResponse == null) {
        throw Exception(
            'Failed to insert transaction details into detailPenjualan table.');
      }

      print('Transaction successfully added!');
    } catch (e) {
      print('Error adding transaction: $e');
      rethrow; // Re-throw the error to handle it in the calling code if needed
    }
  }
}
