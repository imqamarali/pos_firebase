import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_firebase/services/firebase/auth_service.dart';

class AuthController extends ChangeNotifier {
  final authService = AuthService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    try {
      _setLoading(true);
      _error = null;
      await authService.signIn(email, password);
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      _setLoading(true);
      _error = null;
      await authService.signUp(email, password);
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);
      _error = null;
      await authService.signOut();
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _setLoading(true);
      _error = null;
      await authService.resetPassword(email);
    } on FirebaseAuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      _setLoading(true);
      _error = null;
      await authService.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      _setLoading(true);
      _error = null;
      await authService.updatePassword(
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _error = null;
      await authService.deleteAccount(email: email, password: password);
    } catch (e) {
      _error = "Something went wrong";
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
