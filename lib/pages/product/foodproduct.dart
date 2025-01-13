import 'package:flutter/material.dart';
import '../../backend/controllers/routes.dart';
import '../components/appbar.dart'; // Import file appbar.dart

class FoodProduct extends StatelessWidget {
  const FoodProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Hilangkan bayangan jika perlu
        backgroundColor: Colors.transparent, // Gunakan latar belakang transparan
        title: const Center(
          child: Text(
            'Food Products', // Judul halaman
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          // Bisa menambahkan ikon atau tombol lainnya di appbar jika diperlukan
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tampilan untuk produk makanan, bisa diisi dengan ListView atau GridView
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Nasi Goreng'),
                    subtitle: const Text('Stock: 20'),
                    trailing: const Text('Rp 20.000'),
                    onTap: () {
                      // Tindakan ketika item produk ditekan
                    },
                  ),
                  ListTile(
                    title: const Text('Nasi Pecel'),
                    subtitle: const Text('Stock: 24'),
                    trailing: const Text('Rp 19.000'),
                    onTap: () {
                      // Tindakan ketika item produk ditekan
                    },
                  ),
                  // Tambahkan item produk lainnya sesuai kebutuhan
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 0, // Indeks yang aktif, misalnya halaman Home
        onNavTap: (index) {
          // Tindakan untuk berpindah halaman jika bottom nav ditekan
          Navigator.pushNamed(context, AppRoutes.home);
        },
      ),
    );
  }
}
