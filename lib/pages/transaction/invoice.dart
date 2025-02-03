import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../backend/default/constant.dart';
import '../components/appbar.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final supabase = Supabase.instance.client;
  List<dynamic> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchDetail(int penjualanID) async {
    final response = await Supabase.instance.client
        .from('detailpenjualan')
        .select('produkID(namaProduk, harga, jenis), jumlahProduk, subTotal')
        .eq('penjualanID', penjualanID);

    if (response == null) {
      throw Exception('Failed to fetch detail');
    }

    final data = response as List<dynamic>;

    List<Map<String, dynamic>> foodItems = [];
    List<Map<String, dynamic>> drinkItems = [];

    for (var item in data) {
      final produk = item['produkID'];
      final detail = {
        'namaProduk': produk['namaProduk'],
        'harga': produk['harga'],
        'jumlahProduk': item['jumlahProduk'],
        'subTotal': item['subTotal'],
      };

      if (produk['jenis'] == 1) {
        foodItems.add(detail);
      } else if (produk['jenis'] == 2) {
        drinkItems.add(detail);
      }
    }

    return {
      'Food': foodItems,
      'Drink': drinkItems,
    };
  }

  Future<void> fetchTransactions() async {
    try {
      final response = await supabase
          .from('penjualan')
          .select('penjualanID, tanggalPenjualan, totalHarga, pelangganID(namaPelanggan)')
          .order('created_at', ascending: false);

      setState(() {
        transactions = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching invoices: $e')),
      );
    }
  }

  void showTransactionDetails(BuildContext context, int penjualanID) async {
    try {
      final details = await fetchDetail(penjualanID);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Detail Transaction'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (details['Food']!.isNotEmpty) ...[
                  const Text('Food',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...details['Food']!.map((item) => ListTile(
                        title: Text(item['namaProduk']),
                        subtitle: Text(
                            'Jumlah: ${item['jumlahProduk']}, Harga: ${item['harga']}'),
                        trailing: Text('Subtotal: ${item['subTotal']}'),
                      )),
                ],
                if (details['Drink']!.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  const Text('Drink',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...details['Drink']!.map((item) => ListTile(
                        title: Text(item['namaProduk']),
                        subtitle: Text(
                            'Jumlah: ${item['jumlahProduk']}, Harga: ${item['harga']}'),
                        trailing: Text('Subtotal: ${item['subTotal']}'),
                      )),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading transaction details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 26),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (transactions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(AppDefaults.padding),
                    child: Center(
                      child: Text('No transactions available.'),
                    ),
                  );
                }

                final transaction = transactions[index];
                final String tanggal = transaction['tanggalPenjualan'];
                final tanggalFormated = DateFormat('d MMMM yyyy', 'id_ID')
                    .format(DateTime.parse(tanggal));
                final int totalHarga = transaction['totalHarga'];
                final String namaPelanggan = transaction['pelangganID']['namaPelanggan'] ?? 'Non Member';

                return Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: GestureDetector(
                    onTap: () => showTransactionDetails(
                        context, transaction['penjualanID']),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          tanggalFormated,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Customer: $namaPelanggan'),
                        trailing: Text('Rp ${totalHarga.toString()}'),
                      ),
                    ),
                  ),
                );
              },
              childCount: transactions.length,
            ),
          )
        ],
      ),
    );
  }
}
