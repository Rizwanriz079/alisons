class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://sungod.demospro2023.in.net/api';
  static const String imageBaseUrl = 'https://sungod.demospro2023.in.net';
  
  // Endpoints
  static const String login = '/login';
  static const String home = '/home/en';
  static const String products = '/products/en';
  static const String productDetails = '/product-details/en';
  static const String cart = '/cart/en';
  static const String addToCart = '/cart/add/en';
  
  // Test Credentials
  static const String testEmail = 'mobile@alisonsgroup.com';
  static const String testPassword = '12345678';
  
  // Request Parameters
  static const String paramId = 'id';
  static const String paramToken = 'token';
  static const String paramBy = 'by';
  static const String paramValue = 'value';
  static const String paramSlug = 'slug';
  static const String paramQuantity = 'quantity';
  static const String paramStore = 'store';
  
  // Filter Types
  static const String filterByCategory = 'category';
  static const String filterByBrand = 'brand';
  static const String filterByStore = 'store';
}
