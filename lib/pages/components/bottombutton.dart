import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Warna tombol hijau
          minimumSize: const Size.fromHeight(50), // Tinggi tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Radius sudut tombol
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
