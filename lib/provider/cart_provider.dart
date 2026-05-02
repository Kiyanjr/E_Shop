import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:shop/model/product_item.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductItem> _items = [];

  List<ProductItem> get items => _items.toList();

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.price * item.numbersOfProduct);

  void adddToCart(ProductItem product) {
    final index = _items.indexWhere((i) => i.id == product.id);
    if (index >= 0) {
      final old = _items[index];
      _items[index] = old.copyWith(
        numbersOfProduct: old.numbersOfProduct + product.numbersOfProduct,
      );
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(ProductItem productId) {
    // ignore: unrelated_type_equality_checks
    _items.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  void changeQuantity(String productId, double quantity) {
    if (quantity <= 0) {
      removeFromCart(productId as ProductItem);
      return;
    }
    final index = _items.indexWhere((e) => e.id == productId);
    if (index == -1) return;

    _items[index] = _items[index].copyWith(numbersOfProduct:quantity);
    notifyListeners();
  }
}
