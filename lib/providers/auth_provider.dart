import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../utils/api_constants.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String emailOrPhone, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(emailOrPhone, password);

      if (response['success'] == 1 && response['customerdata'] != null) {
        final customerData = response['customerdata'] as Map<String, dynamic>;
        final userId = customerData['id']?.toString() ?? '';
        final token = customerData['token']?.toString() ?? '';

        _user = User(
          id: userId,
          email: emailOrPhone,
          token: token,
        );

        await _saveUserToPreferences();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    _apiService.clearAuthCredentials();
    await _clearUserFromPreferences();
    notifyListeners();
  }

  Future<void> loadUserFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      final userEmail = prefs.getString('user_email');
      final userToken = prefs.getString('user_token');

      if (userId != null && userEmail != null && userToken != null) {
        _user = User(
          id: userId,
          email: userEmail,
          token: userToken,
        );
        _apiService.setAuthCredentials(userId, userToken);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user: $e');
    }
  }

  Future<void> _saveUserToPreferences() async {
    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', _user!.id);
      await prefs.setString('user_email', _user!.email);
      await prefs.setString('user_token', _user!.token);
    }
  }

  Future<void> _clearUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_token');
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
