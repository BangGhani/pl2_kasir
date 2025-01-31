import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardList extends StatelessWidget {
  const CardList({
    super.key,
    required this.title,
    required this.onTap,
    required this.products,
  });

  final String title;
  final void Function() onTap;
  final List<ProductList> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and View All Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: onTap,
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Horizontal Scroll View for Vertical Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(
              products.length ~/ 2 + (products.length % 2),
              (columnIndex) {
                // Subset the list of products into columns
                final firstIndex = columnIndex * 2;
                final secondIndex = firstIndex + 1;

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        child: products[firstIndex],
                      ),
                      const SizedBox(height: 8),
                      if (secondIndex < products.length)
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 48,
                          child: products[secondIndex],
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.name,
    required this.stock,
    required this.price,
  });

  final String name;
  final String stock;
  final String price;

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
                  'Stock: $stock',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Harga
            Text(
              'Rp ${NumberFormat('#,###').format(int.parse(price))}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
