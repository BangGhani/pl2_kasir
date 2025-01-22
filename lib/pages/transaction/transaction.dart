import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../backend/default/constant.dart';
import '../components/transactiondetalis.dart';
import '../components/transactionlist.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? selectedValue; // Variabel untuk menyimpan nilai dropdown
  List<String> dropdownItems = []; // Daftar item dropdown

  @override
  void initState() {
    super.initState();
    fetchCustomers(); // Panggil fungsi untuk memuat data pelanggan
  }

  Future<void> fetchCustomers() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('pelanggan') // Ganti dengan nama tabel di Supabase
          .select('namaPelanggan');

      if (response != null) {
        setState(() {
          // Konversi hasil query menjadi list string
          dropdownItems = List<String>.from(
            response.map((customer) => customer['namaPelanggan']),
          );
        });
      }
    } catch (e) {
      // Tangani kesalahan
      debugPrint('Error fetching customers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Transaction',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        Form(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Product',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(AppDefaults.padding),
                                child: SvgPicture.asset(
                                  AppIcons.search,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(),
                              contentPadding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            textInputAction: TextInputAction.search,
                            autofocus: true,
                            onChanged: (String? value) {},
                            onFieldSubmitted: (v) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SingleCartItemTile(
                      title: 'Sate',
                      price: '12000',
                      type: 'Makanan',
                    ),
                    const Text(
                      'Customer',
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        isExpanded: true,
                        hint: const Text('Select Customer'),
                        items: dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                      ),
                    ),
                    ItemTotalsAndPrice(
                      totalItem: 30,
                      totalPrice: '12000',
                      customer: selectedValue ?? 'Select Customer',
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: ElevatedButton(
                          onPressed: () {
                            // Tambahkan logika checkout di sini
                          },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
