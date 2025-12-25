import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _products = [];
  Product? _selectedProduct;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get hasProducts => _products.isNotEmpty;

  Future<void> loadProducts({
    required String by,
    required String value,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getProducts(
        by: by,
        value: value,
      );

      if (response['success'] == 1) {
        if (response['products'] != null) {
          final productsData = response['products'];
          if (productsData is List) {
            _products = productsData
                .map((json) => Product.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            _products = [];
          }
        } else {
          _products = [];
        }

        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = response['message'] ?? 'Failed to load products';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProductDetails({
    required String slug,
    String? store,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getProductDetails(
        slug: slug,
        store: store,
      );

      if (response['success'] == 1) {
        if (response['product'] != null) {
          _selectedProduct = Product.fromJson(response['product']);
        }

        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = response['message'] ?? 'Failed to load product';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void clearProducts() {
    _products = [];
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
