import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get itemTotal {
    final price = double.tryParse(product.price) ?? 0.0;
    return price * quantity;
  }

  String get formattedItemTotal {
    return '${product.symbolLeft}${itemTotal.toStringAsFixed(2)}${product.symbolRight}';
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }
}
