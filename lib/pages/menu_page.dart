import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart'; // <-- perbaikan
import '../providers/cart_providers.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProv = Provider.of<MenuProvider>(context);
    final cartProv = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      appBar: AppBar(
        title: Text(
          "Menu Burjoin",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5D4037),
        elevation: 0,
        centerTitle: true,
      ),
      body: menuProv.menus.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.brown))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dua kolom biar rapi
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: menuProv.menus.length,
              itemBuilder: (context, index) {
                final menu = menuProv.menus[index];
                return _buildMenuCard(context, menu, cartProv);
              },
            ),
    );
  }

  Widget _buildMenuCard(BuildContext context, menu, cartProv) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar/Icon Makanan
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Icon(
                menu.jenis == "Makanan" ? Icons.restaurant : Icons.local_drink,
                size: 50,
                color: Colors.orange[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menu.nama,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Rp ${menu.harga}",
                  style: GoogleFonts.poppins(
                    color: Colors.orange[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      cartProv.addToCart(menu);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${menu.nama} ditambah ke keranjang"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D4037),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
