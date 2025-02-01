import 'package:flutter/material.dart';
import '../../backend/default/constant.dart';

class GreenButton extends StatelessWidget {
  final String text; // Teks tombol
  final VoidCallback onPressed; // Fungsi yang akan dijalankan saat tombol ditekan

  const GreenButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Warna tombol hijau
          minimumSize: const Size.fromHeight(50), // Tinggi tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDefaults.radius), // Radius sudut tombol
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
