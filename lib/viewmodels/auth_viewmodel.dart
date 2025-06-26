import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String _error = '';

  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isAuthenticated => _authService.isAuthenticated;
  User? get currentUser => _authService.currentUser;
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      await _authService.signOut();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
