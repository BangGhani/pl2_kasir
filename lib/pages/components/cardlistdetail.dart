import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CardList extends StatelessWidget {
  const CardList({
    super.key,
    required this.products,
  });

  final List<ProductList> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: products[index],
        );
      },
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.delete,
    required this.edit,
  });

  final int id;
  final String name;
  final String stock;
  final String price;
  final VoidCallback delete;
  final VoidCallback edit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nama dan Stok
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Stok: $stock',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Harga dan Ikon Aksi
            Row(
              children: [
                Text(
                  'Rp ${NumberFormat('#,###').format(int.parse(price))}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/edit.svg'),
                  onPressed: edit,
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/delete.svg'),
                  onPressed: delete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
