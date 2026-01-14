import 'package:flutter/material.dart';
import '../models/menu.dart';

class MenuProvider extends ChangeNotifier {
  final List<Menu> _menus = [];
  List<Menu> get menus => _menus;

  void loadMenus() {
    _menus.clear();
    _menus.addAll([
      Menu(nama: "Indomie Goreng", harga: 8000, jenis: "Makanan"),
      Menu(nama: "Indomie Kuah", harga: 7500, jenis: "Makanan"),
      Menu(nama: "Nasi Magelangan", harga: 12000, jenis: "Makanan"),
      Menu(nama: "Nasi Ayam Bali", harga: 13000, jenis: "Makanan"),
      Menu(nama: "Omelet", harga: 10000, jenis: "Makanan"),
      Menu(nama: "Es Teh", harga: 3000, jenis: "Minuman"),
      Menu(nama: "Es Jeruk", harga: 4000, jenis: "Minuman"),
      Menu(nama: "Kopi Hitam", harga: 4000, jenis: "Minuman"),
    ]);
    notifyListeners();
  }

  void addMenu(Menu menu) {
    _menus.add(menu);
    notifyListeners();
  }

  void updateMenu(int index, Menu menu) {
    _menus[index] = menu;
    notifyListeners();
  }

  void deleteMenu(int index) {
    _menus.removeAt(index);
    notifyListeners();
  }
}
