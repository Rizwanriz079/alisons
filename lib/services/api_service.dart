import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  String? _userId;
  String? _userToken;

  ApiService._internal();

  void setAuthCredentials(String userId, String token) {
    _userId = userId;
    _userToken = token;
  }

  void clearAuthCredentials() {
    _userId = null;
    _userToken = null;
  }

  bool get isAuthenticated => _userId != null && _userToken != null;

  String _buildUrl(String endpoint, [Map<String, String>? queryParams]) {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final params = <String, String>{};
    
    if (_userId != null && _userToken != null) {
      params[ApiConstants.paramId] = _userId!;
      params[ApiConstants.paramToken] = _userToken!;
    }
    
    if (queryParams != null) {
      params.addAll(queryParams);
    }
    
    return uri.replace(queryParameters: params.isNotEmpty ? params : null).toString();
  }

  Future<Map<String, dynamic>> login(String emailOrPhone, String password) async {
    try {
      final url = _buildUrl(ApiConstants.login, {
        'email_phone': emailOrPhone,
        'password': password,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['success'] == 1 && data['customerdata'] != null) {
          final customerData = data['customerdata'] as Map<String, dynamic>;
          _userId = customerData['id']?.toString();
          _userToken = customerData['token']?.toString();
        }
        return data;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getHomeData() async {
    try {
      final url = _buildUrl(ApiConstants.home);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load home data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getProducts({
    String by = 'category',
    required String value,
  }) async {
    try {
      final url = _buildUrl(ApiConstants.products, {
        ApiConstants.paramBy: by,
        ApiConstants.paramValue: value,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getProductDetails({
    required String slug,
    String? store,
  }) async {
    try {
      final queryParams = <String, String>{
        ApiConstants.paramSlug: slug,
      };
      if (store != null) {
        queryParams[ApiConstants.paramStore] = store;
      }

      final url = _buildUrl('${ApiConstants.productDetails}/$slug', queryParams);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load product details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> addToCart({
    required String slug,
    required int quantity,
    String? store,
  }) async {
    try {
      final queryParams = <String, String>{
        ApiConstants.paramSlug: slug,
        ApiConstants.paramQuantity: quantity.toString(),
      };
      if (store != null) {
        queryParams[ApiConstants.paramStore] = store;
      }

      final url = _buildUrl(ApiConstants.addToCart, queryParams);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to add to cart: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getCart() async {
    try {
      final url = _buildUrl(ApiConstants.cart);

      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load cart: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  String getImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    
    // For relative paths, add /images/ prefix
    // Category images typically don't have a path prefix
    if (!imagePath.contains('/')) {
      return '${ApiConstants.imageBaseUrl}/images/$imagePath';
    }
    
    return '${ApiConstants.imageBaseUrl}/$imagePath';
  }
}
