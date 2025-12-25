import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.length;
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  // Get total quantity of all items
  int get totalQuantity {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Calculate total price
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.itemTotal);
  }

  // Get formatted total price
  String get formattedTotalPrice {
    if (_items.isEmpty) return '';
    final firstItem = _items.first;
    return '${firstItem.product.symbolLeft}${totalPrice.toStringAsFixed(2)}${firstItem.product.symbolRight}';
  }

  // Check if product is in cart
  bool isInCart(String productSlug) {
    return _items.any((item) => item.product.slug == productSlug);
  }

  // Get cart item by product slug
  CartItem? getCartItem(String productSlug) {
    try {
      return _items.firstWhere((item) => item.product.slug == productSlug);
    } catch (e) {
      return null;
    }
  }

  // Add product to cart
  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.slug == product.slug,
    );

    if (existingIndex >= 0) {
      // Product already in cart, increase quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // Add new item to cart
      _items.add(CartItem(
        product: product,
        quantity: quantity,
      ));
    }

    notifyListeners();
  }

  // Remove product from cart
  void removeFromCart(String productSlug) {
    _items.removeWhere((item) => item.product.slug == productSlug);
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(String productSlug) {
    final item = getCartItem(productSlug);
    if (item != null) {
      item.quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(String productSlug) {
    final item = getCartItem(productSlug);
    if (item != null) {
      if (item.quantity > 1) {
        item.quantity--;
        notifyListeners();
      } else {
        // Remove item if quantity becomes 0
        removeFromCart(productSlug);
      }
    }
  }

  // Update quantity
  void updateQuantity(String productSlug, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productSlug);
      return;
    }

    final item = getCartItem(productSlug);
    if (item != null) {
      item.quantity = quantity;
      notifyListeners();
    }
  }

  // Clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
