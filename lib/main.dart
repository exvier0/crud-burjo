import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import 'providers/menu_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MenuProvider()..loadMenus(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
