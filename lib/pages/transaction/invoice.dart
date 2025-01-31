import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  Future<void> fetchTransactions() async {
    try {
      final response = await supabase
          .from('penjualan')
          .select('tanggalPenjualan, totalHarga, pelangganID(namaPelanggan)')
          .order('tanggalPenjualan', ascending: false);

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
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text('No transactions available.'),
                    ),
                  );
                }

                final transaction = transactions[index];
                final String tanggalPenjualan = transaction['tanggalPenjualan'];
                final int totalHarga = transaction['totalHarga'] ?? 0;
                final String namaPelanggan =
                    transaction['pelangganID']['namaPelanggan'] ?? 'Non Member';

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        tanggalPenjualan,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Customer: $namaPelanggan'),
                      trailing: Text('Rp ${totalHarga.toString()}'),
                    ),
                  ),
                );
              },
              childCount: transactions.length,
            ),
          ),
        ],
      ),
    );
  }
}
