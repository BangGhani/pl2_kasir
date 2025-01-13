import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController {
  Future<String?> login(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return null; // Login berhasil
      } else {
        return "Invalid credentials, please try again."; // Error jika user null
      }
    } catch (e) {
      return e.toString();
    }
  }
}
