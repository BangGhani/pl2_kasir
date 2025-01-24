import 'package:flutter/material.dart';
import '../../backend/default/constant.dart';

class ItemTotalsAndPrice extends StatelessWidget {
  const ItemTotalsAndPrice({
    super.key,
    required this.totalItem,
    required this.totalPrice,
    required this.customer,
  });

  final int totalItem;
  final String customer;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          ItemRow(
            title: 'Total Item',
            value: totalItem.toString(),
          ),
          ItemRow(
            title: 'Customer',
            value: customer,
          ),
          const DottedDivider(),
          ItemRow(
            title: 'Total Price',
            value: totalPrice,
          ),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  const DottedDivider({
    super.key,
    this.isVertical = false,
    this.color,
  });

  final Color? color;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
            30,
            (index) => Container(
              margin: const EdgeInsets.all(3),
              width: 1,
              height: 8,
              color: color ?? Colors.black,
            ),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            30,
            (index) => Container(
              margin: const EdgeInsets.all(3),
              width: 8,
              height: 0.3,
              color: color ?? Colors.black,
            ),
          ),
        ),
      );
    }
  }
}
