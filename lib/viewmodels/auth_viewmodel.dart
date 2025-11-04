// lib/viewmodels/auth_viewmodel.dart
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
    // Inscreve para atualizações de autenticação
    _authSub = _authService.userChanges.listen((user) {
      currentUser = user;
      notifyListeners();
    });

    // Inicializa currentUser imediatamente (caso já esteja logado)
    currentUser = _authService.currentUser;
  }

  // login retorna o usuário pra facilitar lógica na UI se quiser
  Future<User?> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.signInWithEmailPassword(email, password);
      currentUser = user;
      return user;
    } on FirebaseAuthException catch (e) {
      // repassa a exception pro UI para mostrar mensagem apropriada
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
    } on FirebaseAuthException catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    // currentUser será atualizado pelo listener do stream quando o signOut acontecer,
    // mas force a limpeza pra redundância
    currentUser = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
