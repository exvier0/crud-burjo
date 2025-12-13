import 'package:flutter/material.dart';
import '../models/menu.dart';

class MenuProvider extends ChangeNotifier {
  final List<Menu> _menus = [];

  List<Menu> get menus => _menus;

  void loadMenus() {
    // data awal (opsional)
    _menus.addAll([
      Menu(nama: "Indomie Goreng", harga: 8000),
      Menu(nama: "Indomie Kuah", harga: 7500),
      Menu(nama: "Es Teh", harga: 3000),
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
