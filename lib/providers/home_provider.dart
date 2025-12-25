import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../models/category_model.dart' as models;
import '../models/banner_model.dart' as models;
import '../services/api_service.dart';
import '../utils/api_constants.dart';

class HomeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  List<models.Banner> _banners = [];
  List<models.Category> _categories = [];
  List<Product> _newArrivals = [];
  List<Product> _bestSellers = [];
  int _cartCount = 0;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<models.Banner> get banners => _banners;
  List<models.Category> get categories => _categories;
  List<Product> get newArrivals => _newArrivals;
  List<Product> get bestSellers => _bestSellers;
  int get cartCount => _cartCount;

  Future<void> loadHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (!_apiService.isAuthenticated) {
        try {
          final loginResponse = await _apiService.login(
            ApiConstants.testEmail,
            ApiConstants.testPassword,
          );
          
          if (loginResponse['success'] != 1) {
            _errorMessage = loginResponse['message'] ?? 'Auto-login failed';
            _isLoading = false;
            notifyListeners();
            return;
          }
        } catch (e) {
          _errorMessage = 'Auto-login failed: ${e.toString()}';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
      
      final response = await _apiService.getHomeData();

      if (response['success'] == 1) {
        _banners = [];
        if (response['banner1'] != null) {
          final banner1List = response['banner1'] as List;
          _banners.addAll(
            banner1List.map((json) => models.Banner.fromJson(json)).toList(),
          );
        }
        if (response['banner2'] != null) {
          final banner2List = response['banner2'] as List;
          _banners.addAll(
            banner2List.map((json) => models.Banner.fromJson(json)).toList(),
          );
        }

        if (response['categories'] != null) {
          final categoriesList = response['categories'] as List;
          _categories = categoriesList
              .map((json) => models.Category.fromJson(json))
              .toList();
        }

        if (response['newarrivals'] != null) {
          final newArrivalsList = response['newarrivals'] as List;
          _newArrivals = newArrivalsList
              .map((json) => Product.fromJson(json))
              .toList();
        }

        if (response['best_seller'] != null) {
          final bestSellersList = response['best_seller'] as List;
          _bestSellers = bestSellersList
              .map((json) => Product.fromJson(json))
              .toList();
        }

        _cartCount = response['cartcount'] ?? 0;

        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = response['message'] ?? 'Failed to load home data';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshHomeData() async {
    await loadHomeData();
  }

  void updateCartCount(int count) {
    _cartCount = count;
    notifyListeners();
  }
}
