import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../backend/default/constant.dart';

class SingleCartItemTile extends StatelessWidget {
  const SingleCartItemTile({
    super.key,
    required this.title,
    required this.price,
    required this.type,
    required this.total,
    required this.onRemove,
    required this.onAdd,
    required this.onDelete,
  });

  final String title;
  final double price;
  final String type;
  final int total;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Quantity and Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          type,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onRemove,
                        icon: SvgPicture.asset(AppIcons.removeQuantity),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          total.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      IconButton(
                        onPressed: onAdd,
                        icon: SvgPicture.asset(AppIcons.addQuantity),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),

              // Price and Delete label
              Column(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: onDelete,
                    icon: SvgPicture.asset(AppIcons.delete),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${price.toString()}',
                  ),
                ],
              ),
            ],
          ),
          const Divider(thickness: 0.1),
        ],
      ),
    );
  }
}
