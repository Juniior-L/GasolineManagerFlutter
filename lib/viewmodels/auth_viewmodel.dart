import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? currentUser;
  bool isLoading = false;
  StreamSubscription<User?>? _authSub;

  AuthViewModel() {
    _authSub = _authService.userChanges.listen((user) {
      currentUser = user;
      notifyListeners();
    });
    currentUser = _authService.currentUser;
  }

  Future<User?> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.signInWithEmailPassword(email, password);
      currentUser = user;
      return user;
    // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> register(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.createUserWithEmailPassword(
        email,
        password,
      );
      currentUser = user;
      return user;
    // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      currentUser = null;
      await _authService.signOut();
      notifyListeners();

      // print("Logout realizado e stream encerrado!");
    } catch (e) {
      // print("Erro ao deslogar: $e");
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
