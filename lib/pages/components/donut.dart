// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonutItem extends StatelessWidget {
  final Color color;
  final int number;
  final String label;
  final String iconPath; // Path untuk ikon di tengah donat

  const DonutItem({
    super.key,
    required this.color,
    required this.number,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Lingkaran luar (background donat)
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            // Lingkaran dalam (angka dan ikon)
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ikon sebagai background angka
                  SvgPicture.asset(
                    iconPath,
                    width: 60,
                    height: 60,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  // Angka di tengah
                  Text(
                    '$number',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Label di bawah donat
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
