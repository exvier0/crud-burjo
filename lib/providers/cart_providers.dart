import 'package:flutter/material.dart';
import '../models/menu.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items => _items;

  void addToCart(Menu menu) {
    int index = _items.indexWhere((item) => item['menu'].nama == menu.nama);
    if (index != -1) {
      _items[index]['quantity'] += 1;
    } else {
      _items.add({'menu': menu, 'quantity': 1});
    }
    notifyListeners();
  }

  void updateQuantity(int index, int qty) {
    if (qty > 0) {
      _items[index]['quantity'] = qty;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  // Fungsi hapus yang tadi sempet ilang
  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalHarga {
    int total = 0;
    for (var item in _items) {
      total += (item['menu'].harga * item['quantity']) as int;
    }
    return total;
  }
}
