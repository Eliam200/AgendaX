import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const AgendaXApp());
}

class AgendaXApp extends StatelessWidget {
  const AgendaXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgendaX',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}