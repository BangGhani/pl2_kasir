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

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword; // Opsional: untuk field password
  final TextInputType? keyboardType; // Opsional: untuk tipe keyboard

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          obscureText: isPassword, // Untuk field password
          keyboardType: keyboardType, // Tipe keyboard (opsional)
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}