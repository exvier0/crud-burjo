import 'package:flutter/material.dart';
import 'beranda.dart';
import 'pages/menu_page.dart';
import 'login.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _index = 0;

  final List<Widget> _pages = const [BerandaPage(), MenuPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          if (value == 2) {
            // logout
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          } else {
            setState(() => _index = value);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }
}
