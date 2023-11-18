import 'package:flutter/material.dart';
import 'package:todo_list/screen/home_screen.dart';
import 'package:todo_list/services/supabase_config.dart';

void main() {
  supabaseConfig();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
