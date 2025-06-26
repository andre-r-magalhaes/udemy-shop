import 'package:flutter/material.dart';
import 'package:udemy_shop/data/dummy_data.dart';

import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  // bool _showFavoritesOnly = false;
  // List<Product> get items {
  //   if (_showFavoritesOnly) {
  //     return _items.where((product) => product.isFavorite).toList();
  //   } else {
  //     return [..._items];
  //   }
  // }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // factory ProductList.fromJson(List<dynamic> json) {
  //   return ProductList(
  //     products: json.map((item) => Product.fromJson(item)).toList(),
  //   );
  // }
}
