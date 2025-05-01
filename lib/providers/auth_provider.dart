import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _email = 'Terryjackson@gmail.com';
  String _password = '';
  bool _isLoading = false;
  final bool _showPassword = false;
  bool _passwordValid = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get showPassword => _showPassword;
  bool get passwordValid => _passwordValid;
  bool _obscurePassword = true; // Changed from showPassword to obscurePassword for clarity

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    _validatePassword(password);
    notifyListeners();
  }

  void _validatePassword(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    _passwordValid = regex.hasMatch(password);
  }

  Future<void> login() async {
    if (!_passwordValid) return;
    
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoading = false;
    notifyListeners();
  }
}