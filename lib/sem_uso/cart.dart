import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:pedidos/providers/produto.dart';

class CartItem {
  final String id;
  final String title;
  final String productId;
  final int quantity;
  final double price;

  CartItem({
    this.id, // era required, mas dava erro
    @required this.title,
    @required this.quantity,
    @required this.productId,
    @required this.price,
  });
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemsCount {
    return _items.length;
  }

  int get itemsCountForBadge {
    int total = 0;
    _items.values.map((e) => total += e.quantity);
    return total;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    //print(total);
    return total;
  }

//------------------------------------------------------------------------------

  void addItem(Produto product) {
    double price = 10;
    if (items.containsKey(product.cod)) {
      _items.update(
        product.cod.toString(),
        (previousItem) => CartItem(
          id: previousItem.id,
          title: previousItem.title,
          quantity: previousItem.quantity + 1,
          productId: product.cod.toString(),
          price: previousItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.cod.toString(),
        () => CartItem(
          id: Random().nextDouble().toString(),
          title: product.title,
          quantity: 1,
          productId: product.cod.toString(),
          price: price, //product.price,
        ),
      );
    }
    notifyListeners();
  }

//------------------------------------------------------------------------------

  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    } else {
      // só atualiza o item do carrinho para -1 em quantidade
      _items.update(
        productId,
        (previousItem) => CartItem(
          id: previousItem.id,
          title: previousItem.title,
          quantity: previousItem.quantity - 1,
          productId: previousItem.productId,
          price: previousItem.price,
        ),
      );
    }

    notifyListeners();
  }

//------------------------------------------------------------------------------

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

//------------------------------------------------------------------------------

  void clear() {
    _items = {};
    notifyListeners();
  }
}
