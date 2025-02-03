import 'package:flutter/material.dart';
import 'backend/controllers/routes.dart';
import 'backend/default/appThemes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://iitretmvmqzniwdvempi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlpdHJldG12bXF6bml3ZHZlbXBpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxMzI0NDMsImV4cCI6MjA1MTcwODQ0M30.q0y3-EZM76BP0dVf7ko3_jTRt3RW_YCuZ5k6WiWpePI',
  );
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    return MaterialApp(
      title: 'eCashier',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      initialRoute: user != null ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
