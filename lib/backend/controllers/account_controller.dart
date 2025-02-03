import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> registerOfficer(String email, String password, String namaPetugas, String nomorTelepon, String alamat) async {
  final supabase = Supabase.instance.client;

  // Langkah 1: Daftar akun
  final response = await supabase.auth.signUp(email: email, password: password);

  if (response == null) {
    print('Error registering user: ${response}');
    return;
  }

  // Langkah 2: Ambil ID akun yang baru saja dibuat
  final userId = response.user?.id;
  if (userId == null) {
    print('User ID is null');
    return;
  }

  // Langkah 3: Tambahkan data ke tabel petugas
  final petugasResponse = await supabase.from('petugas').insert({
    'namaPetugas': namaPetugas,
    'nomorTelepon': nomorTelepon,
    'alamat': alamat,
    'accountID': userId,
  });

  if (petugasResponse.error != null) {
    print('Error adding petugas: ${petugasResponse.error!.message}');
  } else {
    print('Petugas added successfully');
  }
}

Future<void> registerCustomer(String email, String password, String namaPelanggan, String nomorTelepon, String alamat) async {
  final supabase = Supabase.instance.client;

  // Langkah 1: Daftar akun
  final response = await supabase.auth.signUp(email: email, password: password);
  if (response == null) {
    print('Error registering user: ${response}');
    return;
  }

  // Langkah 2: Ambil ID akun yang baru saja dibuat
  final userId = response.user?.id;
  if (userId == null) {
    print('User ID is null');
    return;
  }

  // Langkah 3: Tambahkan data ke tabel pelanggan
  final pelangganResponse = await supabase.from('pelanggan').insert({
    'namaPelanggan': namaPelanggan,
    'nomorTelepon': nomorTelepon,
    'alamat': alamat,
    'accountID': userId,
  });

  if (pelangganResponse.error != null) {
    print('Error adding pelanggan: ${pelangganResponse.error!.message}');
  } else {
    print('Customer added successfully');
  }
}