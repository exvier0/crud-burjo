import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/menu_provider.dart';
import 'providers/cart_providers.dart';
import 'providers/pesanan_providers.dart';
import 'pages/navbar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()..loadMenus()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => PesananProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Burjo Kresna',
      theme: ThemeData(primarySwatch: Colors.brown, useMaterial3: true),
      home: const Navbar(),
    );
  }
}
