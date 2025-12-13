import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/menu.dart';
import '../providers/menu_provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Menu")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(context),
      ),
      body: provider.menus.isEmpty
          ? const Center(
              child: Text("Belum ada menu", style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              itemCount: provider.menus.length,
              itemBuilder: (context, index) {
                final menu = provider.menus[index];
                return _menuCard(context, menu, index);
              },
            ),
    );
  }

  // ================= FORM TAMBAH / EDIT =================
  void _showForm(BuildContext context, {Menu? menu, int? index}) {
    final nama = TextEditingController(text: menu?.nama);
    final harga = TextEditingController(
      text: menu != null ? menu.harga.toString() : "",
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(menu == null ? "Tambah Menu" : "Edit Menu"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nama,
              decoration: const InputDecoration(
                labelText: "Nama Menu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: harga,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("BATAL"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nama.text.isEmpty || harga.text.isEmpty) return;

              final provider = Provider.of<MenuProvider>(
                context,
                listen: false,
              );

              if (menu == null) {
                provider.addMenu(
                  Menu(nama: nama.text, harga: int.parse(harga.text)),
                );
              } else {
                provider.updateMenu(
                  index!,
                  Menu(nama: nama.text, harga: int.parse(harga.text)),
                );
              }

              Navigator.pop(context);
            },
            child: const Text("SIMPAN"),
          ),
        ],
      ),
    );
  }

  // ================= CARD MENU =================
  Widget _menuCard(BuildContext context, Menu menu, int index) {
    final provider = Provider.of<MenuProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const Icon(Icons.fastfood, color: Colors.brown),
        title: Text(
          menu.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Rp ${menu.harga}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () => _showForm(context, menu: menu, index: index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Hapus Menu"),
                    content: const Text("Yakin ingin menghapus menu ini?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("BATAL"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.deleteMenu(index);
                          Navigator.pop(context);
                        },
                        child: const Text("HAPUS"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
