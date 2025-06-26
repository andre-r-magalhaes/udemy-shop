class CartItem {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => quantity * price;

  @override
  String toString() {
    return 'CartItem(id: $id, title: $name, quantity: $quantity, price: $price)';
  }
}
