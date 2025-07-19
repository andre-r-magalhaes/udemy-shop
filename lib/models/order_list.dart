import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_shop/models/cart_item.dart';
import 'package:udemy_shop/utils/constantes.dart';

import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    var date = DateTime.now();
    var response = await http.post(
      Uri.parse('${Constantes.ORDERS_BASE_URL}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values.map((item) {
          return {
            'id': item.id,
            'productId': item.productId,
            'name': item.name,
            'price': item.price,
            'quantity': item.quantity,
          };
        }).toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'] as String;
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }

  Future<void> loadOrders() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constantes.ORDERS_BASE_URL}.json'),
    );

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((orderId, orderData) {
      _items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              price: item['price'],
              quantity: item['quantity'],
            );
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }
}
